{
  jq,
  lib,
  applyPatches,
  buildNpmPackage,
  fetchurl,
  importNpmLock,
  nodejs,
  writeShellApplication,
  fetchTreeFromGitHub,
}:
with rec {
  pname = "tyche";
  version = "b989afcf7bfb422b5c3bd0eb3fc95e13bc66b368";
  tyche-src = applyPatches {
    name = "tyche-patched";
    src = fetchTreeFromGitHub {
      owner = "tyche-pbt";
      repo = "tyche-extension";
      tree = version;
    };
    postPatch = ''
      export PATH="${jq}/bin:$PATH"

      echo "Patching observability-tools" 1>&2

      jq '(.compilerOptions.target |= "es2017") |
          (.compilerOptions.lib += ["es2017"])' \
        < observability-tools/tsconfig.json \
        > observability-tools/tsconfig.json.new

      jq --slurpfile p package.json '.dependencies += {
        zod  : $p[0].dependencies.zod,
        json5: $p[0].dependencies.json5
      }' < observability-tools/package.json \
         > observability-tools/package.json.new

      jq --slurpfile pl package-lock.json '
        (.packages."".dependencies |= {
          zod  : $pl[0].packages."".dependencies.zod,
          json5: $pl[0].packages."".dependencies.json5
        }) |
        (.packages."node_modules/zod" |= $pl[0].packages."node_modules/zod") |
        (.packages."node_modules/json5" |= $pl[0].packages."node_modules/json5")
      ' < observability-tools/package-lock.json \
        > observability-tools/package-lock.json.new

      mv observability-tools/tsconfig.json.new \
         observability-tools/tsconfig.json
      mv observability-tools/package.json.new \
         observability-tools/package.json
      mv observability-tools/package-lock.json.new \
         observability-tools/package-lock.json

      echo "Patching webview-ui" 1>&2

      jq --slurpfile p package.json '.dependencies += {
        zod : $p[0].dependencies.zod,
        "react": "^18.2.0",
        "react-dom": "^18.2.0"
      }' < webview-ui/package.json > webview-ui/package.json.new

      jq --slurpfile pl package-lock.json '
        (.packages."".dependencies += {
          zod : $pl[0].packages."".dependencies.zod,
          "react": "^18.2.0",
          "react-dom": "^18.2.0"
        }) |
        (.packages."node_modules/zod" |= $pl[0].packages."node_modules/zod") |
        (.packages."node_modules/react".version |= "18.2.0") |
        (.packages."node_modules/react".integrity |= "sha512-/3IjMdb2L9QbBdWiW5e3P2/npwMBaU9mHCSCUzNln0ZCYbcfTsGbTJrU/kGemdH2IWmB2ioZ+zkxtmq6g09fGQ==") |
        (.packages."node_modules/react-dom".version |= "18.2.0") |
        (.packages."node_modules/react-dom".integrity |= "sha512-6IMTriUmvsjHUjNtEDudZfuDQUoWXVxKHhlEGSk81n4YFS+r/Kl99wXiwlVXtPBtJenozv2P+hxDsw9eA7Xo6g==") |
        (.packages."node_modules/react-dom".dependencies.scheduler |= "^0.23.0") |
        (.packages."node_modules/scheduler".version |= "0.23.2") |
        (.packages."node_modules/scheduler".integrity |= "sha512-UOShsPwz7NrMUqhR6t0hWjFduvOzbtv7toDH1/hIrfRNIDBnnBWd0CwJTGvTpngVlmwGCdP9/Zl/tVrDqcuYzQ==")
      ' < webview-ui/package-lock.json > webview-ui/package-lock.json.new

      jq '.compilerOptions.jsx |= "react"' \
        < webview-ui/tsconfig.json \
        > webview-ui/tsconfig.json.new

      mv webview-ui/package.json.new      webview-ui/package.json
      mv webview-ui/package-lock.json.new webview-ui/package-lock.json

      # Avoid needing the sass package: rename .scss to .css, flattening
      # all nested rules (e.g. .parent { .child { ... } } becomes
      # .parent { } .parent .child { ... })
      sed -i 's|import "./index.scss"|import "./index.css"|' \
        webview-ui/src/index.tsx
      awk '
        # Track brace depth and parent selector
        /^[^ \t].*\{/ && depth==0 {
          parent=$0; sub(/ *\{.*/, "", parent); depth=1
          props=""; next
        }
        depth==1 && /\{/ {
          child=$0; sub(/ *\{.*/, "", child); gsub(/^ +/, "", child)
          depth=2; print parent " " child " {"; next
        }
        depth==2 && /\}/ { print; depth=1; next }
        depth==1 && /^\}/ {
          if (props != "") print parent " {\n" props "}\n"
          depth=0; next
        }
        depth==1 { props = props $0 "\n" }
        depth==0 { print }
        depth==2 { print }
      ' webview-ui/src/index.scss > webview-ui/src/index.css
      rm webview-ui/src/index.scss
    '';
  };

  observability-tools = buildNpmPackage rec {
    pname = "observability-tools";
    version = "1.0.0";
    src = "${tyche-built}/lib/node_modules/tyche/${pname}";
    npmDeps = importNpmLock { npmRoot = src; };
    npmConfigHook = importNpmLock.npmConfigHook;
  };

  tyche-with-observability-tools = applyPatches {
    name = "tyche-with-observability-tools";
    src = "${tyche-built}/lib/node_modules/tyche";
    postPatch = ''
      rm -r observability-tools
      ln -s ${observability-tools}/lib/node_modules/observability-tools \
            observability-tools
    '';
  };

  # Fetch react 18 tarballs to override the lock file's react 17 entries.
  # react-markdown 9 is ESM and imports react/jsx-runtime; react 18's package
  # exports field maps that correctly, while react 17 lacks exports entirely.
  # Using fetchurl (not fetchTarball) so npm extracts them into node_modules
  # rather than symlinking a directory (which breaks module resolution).
  react-18 = fetchurl {
    url = "https://registry.npmjs.org/react/-/react-18.2.0.tgz";
    hash = "sha256-oVH3yuyRF2DkK3pvbx38q6FB/RH/SeKvkBou7gNmKXw=";
  };
  react-dom-18 = fetchurl {
    url = "https://registry.npmjs.org/react-dom/-/react-dom-18.2.0.tgz";
    hash = "sha256-IKcehraR+GDHgfNzKoXHs8Y8TT2agD3Knf5u0Osw4u8=";
  };
  scheduler-23 = fetchurl {
    url = "https://registry.npmjs.org/scheduler/-/scheduler-0.23.2.tgz";
    hash = "sha256-5PHY/mOpq5PvZskrCtGvnBMmrb9/G9XpBTysD+5vJq4=";
  };

  generator-visualizer = buildNpmPackage {
    inherit version;
    pname = "generator-visualizer";
    src = "${tyche-with-observability-tools}/webview-ui";
    npmDeps = importNpmLock {
      npmRoot = "${tyche-with-observability-tools}/webview-ui";
      packageSourceOverrides = {
        "node_modules/react" = react-18;
        "node_modules/react-dom" = react-dom-18;
        "node_modules/scheduler" = scheduler-23;
      };
    };
    npmConfigHook = importNpmLock.npmConfigHook;
    dontNpmBuild = true;
    dontNpmPrune = true;
    npmFlags = [ "--legacy-peer-deps" ];
  };

  tyche-built = buildNpmPackage {
    inherit pname version;
    src = tyche-src;
    npmDeps = importNpmLock { npmRoot = tyche-src; };
    npmConfigHook = importNpmLock.npmConfigHook;
    dontNpmBuild = true;
    dontNpmPrune = true;
    npmFlags = [ "--legacy-peer-deps" ];
  };
};
writeShellApplication {
  name = "tyche-start";
  text = ''
    cd "$dir/lib/node_modules/generator-visualizer" || exit 1
    exec npm run start
  '';
  runtimeInputs = [ nodejs ];
  runtimeEnv.dir = generator-visualizer;
}
// {
  inherit observability-tools generator-visualizer tyche-built;
}
