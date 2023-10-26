let
  buildDepError = pkg:
    builtins.throw ''
      The Haskell package set does not contain the package: ${pkg} (build dependency).

      If you are using Stackage, make sure that you are using a snapshot that contains the package. Otherwise you may need to update the Hackage snapshot you are using, usually by updating haskell.nix.
    '';
  sysDepError = pkg:
    builtins.throw ''
      The Nixpkgs package set does not contain the package: ${pkg} (system dependency).

      You may need to augment the system package mapping in haskell.nix so that it can be found.
    '';
  pkgConfDepError = pkg:
    builtins.throw ''
      The pkg-conf packages does not contain the package: ${pkg} (pkg-conf dependency).

      You may need to augment the pkg-conf package mapping in haskell.nix so that it can be found.
    '';
  exeDepError = pkg:
    builtins.throw ''
      The local executable components do not include the component: ${pkg} (executable dependency).
    '';
  legacyExeDepError = pkg:
    builtins.throw ''
      The Haskell package set does not contain the package: ${pkg} (executable dependency).

      If you are using Stackage, make sure that you are using a snapshot that contains the package. Otherwise you may need to update the Hackage snapshot you are using, usually by updating haskell.nix.
    '';
  buildToolDepError = pkg:
    builtins.throw ''
      Neither the Haskell package set or the Nixpkgs package set contain the package: ${pkg} (build tool dependency).

      If this is a system dependency:
      You may need to augment the system package mapping in haskell.nix so that it can be found.

      If this is a Haskell dependency:
      If you are using Stackage, make sure that you are using a snapshot that contains the package. Otherwise you may need to update the Hackage snapshot you are using, usually by updating haskell.nix.
    '';
in { system, compiler, flags, pkgs, hsPkgs, pkgconfPkgs, ... }:
{
  flags = {
    static = false;
    embed_data_files = false;
    trypandoc = false;
  };
  package = {
    specVersion = "2.0";
    identifier = {
      name = "pandoc";
      version = "2.9.1";
    };
    license = "GPL-2.0-only";
    copyright = "(c) 2006-2019 John MacFarlane";
    maintainer = "John MacFarlane <jgm@berkeley.edu>";
    author = "John MacFarlane <jgm@berkeley.edu>";
    homepage = "https://pandoc.org";
    url = "";
    synopsis = "Conversion between markup formats";
    description = ''
      Pandoc is a Haskell library for converting from one markup
      format to another, and a command-line tool that uses
      this library. It can read several dialects of Markdown and
      (subsets of) HTML, reStructuredText, LaTeX, DocBook, JATS,
      MediaWiki markup, DokuWiki markup, TWiki markup,
      TikiWiki markup, Jira markup, Creole 1.0, Haddock markup,
      OPML, Emacs Org-Mode, Emacs Muse, txt2tags, ipynb (Jupyter
      notebooks), Vimwiki, Word Docx, ODT, EPUB, FictionBook2,
      roff man, and Textile, and it can write Markdown,
      reStructuredText, XHTML, HTML 5, LaTeX, ConTeXt, DocBook,
      JATS, OPML, TEI, OpenDocument, ODT, Word docx,
      PowerPoint pptx, RTF, MediaWiki, DokuWiki, XWiki,
      ZimWiki, Textile, Jira, roff man, roff ms, plain text,
      Emacs Org-Mode, AsciiDoc, Haddock markup,
      EPUB (v2 and v3), ipynb, FictionBook2,
      InDesign ICML, Muse, LaTeX beamer slides,
      and several kinds of HTML/JavaScript slide shows
      (S5, Slidy, Slideous, DZSlides, reveal.js).

      In contrast to most existing tools for converting Markdown
      to HTML, pandoc has a modular design: it consists of a set of
      readers, which parse text in a given format and produce a
      native representation of the document, and a set of writers,
      which convert this native representation into a target
      format. Thus, adding an input or output format requires
      only adding a reader or writer.'';
    buildType = "Simple";
    isLocal = true;
    detailLevel = "FullDetails";
    licenseFiles = [ "COPYING.md" ];
    dataDir = "";
    dataFiles = [
      "data/templates/styles.html"
      "data/templates/default.html4"
      "data/templates/default.html5"
      "data/templates/default.docbook4"
      "data/templates/default.docbook5"
      "data/templates/default.jats"
      "data/templates/default.tei"
      "data/templates/default.opendocument"
      "data/templates/default.icml"
      "data/templates/default.opml"
      "data/templates/default.latex"
      "data/templates/default.context"
      "data/templates/default.texinfo"
      "data/templates/default.jira"
      "data/templates/default.man"
      "data/templates/default.ms"
      "data/templates/default.markdown"
      "data/templates/default.muse"
      "data/templates/default.commonmark"
      "data/templates/default.rst"
      "data/templates/default.plain"
      "data/templates/default.mediawiki"
      "data/templates/default.dokuwiki"
      "data/templates/default.xwiki"
      "data/templates/default.zimwiki"
      "data/templates/default.rtf"
      "data/templates/default.s5"
      "data/templates/default.slidy"
      "data/templates/default.slideous"
      "data/templates/default.revealjs"
      "data/templates/default.dzslides"
      "data/templates/default.asciidoc"
      "data/templates/default.asciidoctor"
      "data/templates/default.haddock"
      "data/templates/default.textile"
      "data/templates/default.org"
      "data/templates/default.epub2"
      "data/templates/default.epub3"
      "data/translations/*.yaml"
      "data/docx/[Content_Types].xml"
      "data/docx/_rels/.rels"
      "data/docx/docProps/app.xml"
      "data/docx/docProps/core.xml"
      "data/docx/docProps/custom.xml"
      "data/docx/word/document.xml"
      "data/docx/word/fontTable.xml"
      "data/docx/word/comments.xml"
      "data/docx/word/footnotes.xml"
      "data/docx/word/numbering.xml"
      "data/docx/word/settings.xml"
      "data/docx/word/webSettings.xml"
      "data/docx/word/styles.xml"
      "data/docx/word/_rels/document.xml.rels"
      "data/docx/word/_rels/footnotes.xml.rels"
      "data/docx/word/theme/theme1.xml"
      "data/odt/mimetype"
      "data/odt/manifest.rdf"
      "data/odt/styles.xml"
      "data/odt/content.xml"
      "data/odt/meta.xml"
      "data/odt/settings.xml"
      "data/odt/Configurations2/accelerator/current.xml"
      "data/odt/Thumbnails/thumbnail.png"
      "data/odt/META-INF/manifest.xml"
      "data/pptx/_rels/.rels"
      "data/pptx/docProps/app.xml"
      "data/pptx/docProps/core.xml"
      "data/pptx/ppt/slideLayouts/_rels/slideLayout1.xml.rels"
      "data/pptx/ppt/slideLayouts/_rels/slideLayout2.xml.rels"
      "data/pptx/ppt/slideLayouts/_rels/slideLayout3.xml.rels"
      "data/pptx/ppt/slideLayouts/_rels/slideLayout4.xml.rels"
      "data/pptx/ppt/slideLayouts/_rels/slideLayout5.xml.rels"
      "data/pptx/ppt/slideLayouts/_rels/slideLayout6.xml.rels"
      "data/pptx/ppt/slideLayouts/_rels/slideLayout7.xml.rels"
      "data/pptx/ppt/slideLayouts/_rels/slideLayout8.xml.rels"
      "data/pptx/ppt/slideLayouts/_rels/slideLayout9.xml.rels"
      "data/pptx/ppt/slideLayouts/_rels/slideLayout10.xml.rels"
      "data/pptx/ppt/slideLayouts/_rels/slideLayout11.xml.rels"
      "data/pptx/ppt/slideLayouts/slideLayout1.xml"
      "data/pptx/ppt/slideLayouts/slideLayout2.xml"
      "data/pptx/ppt/slideLayouts/slideLayout3.xml"
      "data/pptx/ppt/slideLayouts/slideLayout4.xml"
      "data/pptx/ppt/slideLayouts/slideLayout5.xml"
      "data/pptx/ppt/slideLayouts/slideLayout6.xml"
      "data/pptx/ppt/slideLayouts/slideLayout7.xml"
      "data/pptx/ppt/slideLayouts/slideLayout8.xml"
      "data/pptx/ppt/slideLayouts/slideLayout9.xml"
      "data/pptx/ppt/slideLayouts/slideLayout10.xml"
      "data/pptx/ppt/slideLayouts/slideLayout11.xml"
      "data/pptx/ppt/_rels/presentation.xml.rels"
      "data/pptx/ppt/theme/theme1.xml"
      "data/pptx/ppt/presProps.xml"
      "data/pptx/ppt/slides/_rels/slide1.xml.rels"
      "data/pptx/ppt/slides/_rels/slide2.xml.rels"
      "data/pptx/ppt/slides/slide2.xml"
      "data/pptx/ppt/slides/slide1.xml"
      "data/pptx/ppt/slides/_rels/slide3.xml.rels"
      "data/pptx/ppt/slides/_rels/slide4.xml.rels"
      "data/pptx/ppt/slides/slide3.xml"
      "data/pptx/ppt/slides/slide4.xml"
      "data/pptx/ppt/viewProps.xml"
      "data/pptx/ppt/tableStyles.xml"
      "data/pptx/ppt/slideMasters/_rels/slideMaster1.xml.rels"
      "data/pptx/ppt/slideMasters/slideMaster1.xml"
      "data/pptx/ppt/presentation.xml"
      "data/pptx/ppt/notesMasters/_rels/notesMaster1.xml.rels"
      "data/pptx/ppt/notesMasters/notesMaster1.xml"
      "data/pptx/ppt/notesSlides/_rels/notesSlide1.xml.rels"
      "data/pptx/ppt/notesSlides/notesSlide1.xml"
      "data/pptx/ppt/notesSlides/_rels/notesSlide2.xml.rels"
      "data/pptx/ppt/notesSlides/notesSlide2.xml"
      "data/pptx/ppt/theme/theme2.xml"
      "data/pptx/[Content_Types].xml"
      "data/epub.css"
      "data/dzslides/template.html"
      "data/abbreviations"
      "data/sample.lua"
      "data/init.lua"
      "data/pandoc.lua"
      "data/pandoc.List.lua"
      "data/bash_completion.tpl"
      "data/jats.csl"
      "MANUAL.txt"
      "COPYRIGHT"
    ];
    extraSrcFiles = [
      "INSTALL.md"
      "AUTHORS.md"
      "README.md"
      "CONTRIBUTING.md"
      "BUGS"
      "changelog.md"
      "man/pandoc.1"
      "cabal.project"
      "stack.yaml"
      "man/manfilter.lua"
      "man/pandoc.1.before"
      "man/pandoc.1.after"
      "trypandoc/Makefile"
      "trypandoc/index.html"
      "test/bodybg.gif"
      "test/*.native"
      "test/command/*.md"
      "test/command/A.txt"
      "test/command/B.txt"
      "test/command/C.txt"
      "test/command/D.txt"
      "test/command/defaults1.yaml"
      "test/command/defaults2.yaml"
      "test/command/3533-rst-csv-tables.csv"
      "test/command/3880.txt"
      "test/command/5182.txt"
      "test/command/5700-metadata-file-1.yml"
      "test/command/5700-metadata-file-2.yml"
      "test/command/abbrevs"
      "test/command/SVG_logo-without-xml-declaration.svg"
      "test/command/SVG_logo.svg"
      "test/command/corrupt.svg"
      "test/command/inkscape-cube.svg"
      "test/command/lua-pandoc-state.lua"
      "test/command/sub-file-chapter-1.tex"
      "test/command/sub-file-chapter-2.tex"
      "test/command/bar.tex"
      "test/command/yaml-metadata.yaml"
      "test/command/3510-subdoc.org"
      "test/command/3510-export.latex"
      "test/command/3510-src.hs"
      "test/command/3971b.tex"
      "test/docbook-chapter.docbook"
      "test/docbook-reader.docbook"
      "test/docbook-xref.docbook"
      "test/html-reader.html"
      "test/opml-reader.opml"
      "test/org-select-tags.org"
      "test/haddock-reader.haddock"
      "test/insert"
      "test/lalune.jpg"
      "test/man-reader.man"
      "test/movie.jpg"
      "test/media/rId25.jpg"
      "test/media/rId26.jpg"
      "test/media/rId27.jpg"
      "test/latex-reader.latex"
      "test/textile-reader.textile"
      "test/markdown-reader-more.txt"
      "test/markdown-citations.txt"
      "test/textile-reader.textile"
      "test/mediawiki-reader.wiki"
      "test/vimwiki-reader.wiki"
      "test/creole-reader.txt"
      "test/rst-reader.rst"
      "test/jats-reader.xml"
      "test/jira-reader.jira"
      "test/s5-basic.html"
      "test/s5-fancy.html"
      "test/s5-fragment.html"
      "test/s5-inserts.html"
      "test/tables.context"
      "test/tables.docbook4"
      "test/tables.docbook5"
      "test/tables.jats"
      "test/tables.jira"
      "test/tables.dokuwiki"
      "test/tables.zimwiki"
      "test/tables.icml"
      "test/tables.html4"
      "test/tables.html5"
      "test/tables.latex"
      "test/tables.man"
      "test/tables.ms"
      "test/tables.plain"
      "test/tables.markdown"
      "test/tables.mediawiki"
      "test/tables.tei"
      "test/tables.textile"
      "test/tables.opendocument"
      "test/tables.org"
      "test/tables.asciidoc"
      "test/tables.haddock"
      "test/tables.texinfo"
      "test/tables.rst"
      "test/tables.rtf"
      "test/tables.txt"
      "test/tables.fb2"
      "test/tables.muse"
      "test/tables.custom"
      "test/tables.xwiki"
      "test/testsuite.txt"
      "test/writer.latex"
      "test/writer.context"
      "test/writer.docbook4"
      "test/writer.docbook5"
      "test/writer.jats"
      "test/writer.jira"
      "test/writer.html4"
      "test/writer.html5"
      "test/writer.man"
      "test/writer.ms"
      "test/writer.markdown"
      "test/writer.plain"
      "test/writer.mediawiki"
      "test/writer.textile"
      "test/writer.opendocument"
      "test/writer.org"
      "test/writer.asciidoc"
      "test/writer.haddock"
      "test/writer.rst"
      "test/writer.icml"
      "test/writer.rtf"
      "test/writer.tei"
      "test/writer.texinfo"
      "test/writer.fb2"
      "test/writer.opml"
      "test/writer.dokuwiki"
      "test/writer.zimwiki"
      "test/writer.xwiki"
      "test/writer.muse"
      "test/writer.custom"
      "test/writers-lang-and-dir.latex"
      "test/writers-lang-and-dir.context"
      "test/dokuwiki_inline_formatting.dokuwiki"
      "test/lhs-test.markdown"
      "test/lhs-test.markdown+lhs"
      "test/lhs-test.rst"
      "test/lhs-test.rst+lhs"
      "test/lhs-test.latex"
      "test/lhs-test.latex+lhs"
      "test/lhs-test.html"
      "test/lhs-test.html+lhs"
      "test/lhs-test.fragment.html+lhs"
      "test/pipe-tables.txt"
      "test/dokuwiki_external_images.dokuwiki"
      "test/dokuwiki_multiblock_table.dokuwiki"
      "test/fb2/*.markdown"
      "test/fb2/*.fb2"
      "test/fb2/images-embedded.html"
      "test/fb2/images-embedded.fb2"
      "test/fb2/test-small.png"
      "test/fb2/reader/*.fb2"
      "test/fb2/reader/*.native"
      "test/fb2/test.jpg"
      "test/docx/*.docx"
      "test/docx/golden/*.docx"
      "test/docx/*.native"
      "test/epub/*.epub"
      "test/epub/*.native"
      "test/pptx/*.pptx"
      "test/pptx/*.native"
      "test/ipynb/*.in.native"
      "test/ipynb/*.out.native"
      "test/ipynb/*.ipynb"
      "test/txt2tags.t2t"
      "test/twiki-reader.twiki"
      "test/tikiwiki-reader.tikiwiki"
      "test/odt/odt/*.odt"
      "test/odt/markdown/*.md"
      "test/odt/native/*.native"
      "test/lua/*.lua"
      "test/lua/module/*.lua"
    ];
    extraTmpFiles = [ ];
    extraDocFiles = [ ];
  };
  components = {
    "library" = {
      depends = ((([
        (hsPkgs."base" or (buildDepError "base"))
        (hsPkgs."syb" or (buildDepError "syb"))
        (hsPkgs."containers" or (buildDepError "containers"))
        (hsPkgs."unordered-containers" or (buildDepError
          "unordered-containers"))
        (hsPkgs."parsec" or (buildDepError "parsec"))
        (hsPkgs."mtl" or (buildDepError "mtl"))
        (hsPkgs."exceptions" or (buildDepError "exceptions"))
        (hsPkgs."filepath" or (buildDepError "filepath"))
        (hsPkgs."process" or (buildDepError "process"))
        (hsPkgs."directory" or (buildDepError "directory"))
        (hsPkgs."bytestring" or (buildDepError "bytestring"))
        (hsPkgs."text" or (buildDepError "text"))
        (hsPkgs."time" or (buildDepError "time"))
        (hsPkgs."safe" or (buildDepError "safe"))
        (hsPkgs."zip-archive" or (buildDepError "zip-archive"))
        (hsPkgs."HTTP" or (buildDepError "HTTP"))
        (hsPkgs."texmath" or (buildDepError "texmath"))
        (hsPkgs."xml" or (buildDepError "xml"))
        (hsPkgs."split" or (buildDepError "split"))
        (hsPkgs."random" or (buildDepError "random"))
        (hsPkgs."pandoc-types" or (buildDepError "pandoc-types"))
        (hsPkgs."aeson" or (buildDepError "aeson"))
        (hsPkgs."scientific" or (buildDepError "scientific"))
        (hsPkgs."aeson-pretty" or (buildDepError "aeson-pretty"))
        (hsPkgs."tagsoup" or (buildDepError "tagsoup"))
        (hsPkgs."base64-bytestring" or (buildDepError "base64-bytestring"))
        (hsPkgs."zlib" or (buildDepError "zlib"))
        (hsPkgs."skylighting" or (buildDepError "skylighting"))
        (hsPkgs."skylighting-core" or (buildDepError "skylighting-core"))
        (hsPkgs."data-default" or (buildDepError "data-default"))
        (hsPkgs."temporary" or (buildDepError "temporary"))
        (hsPkgs."blaze-html" or (buildDepError "blaze-html"))
        (hsPkgs."blaze-markup" or (buildDepError "blaze-markup"))
        (hsPkgs."vector" or (buildDepError "vector"))
        (hsPkgs."jira-wiki-markup" or (buildDepError "jira-wiki-markup"))
        (hsPkgs."hslua" or (buildDepError "hslua"))
        (hsPkgs."hslua-module-system" or (buildDepError "hslua-module-system"))
        (hsPkgs."hslua-module-text" or (buildDepError "hslua-module-text"))
        (hsPkgs."binary" or (buildDepError "binary"))
        (hsPkgs."SHA" or (buildDepError "SHA"))
        (hsPkgs."haddock-library" or (buildDepError "haddock-library"))
        (hsPkgs."deepseq" or (buildDepError "deepseq"))
        (hsPkgs."JuicyPixels" or (buildDepError "JuicyPixels"))
        (hsPkgs."Glob" or (buildDepError "Glob"))
        (hsPkgs."cmark-gfm" or (buildDepError "cmark-gfm"))
        (hsPkgs."doctemplates" or (buildDepError "doctemplates"))
        (hsPkgs."network-uri" or (buildDepError "network-uri"))
        (hsPkgs."network" or (buildDepError "network"))
        (hsPkgs."http-client" or (buildDepError "http-client"))
        (hsPkgs."http-client-tls" or (buildDepError "http-client-tls"))
        (hsPkgs."http-types" or (buildDepError "http-types"))
        (hsPkgs."case-insensitive" or (buildDepError "case-insensitive"))
        (hsPkgs."unicode-transforms" or (buildDepError "unicode-transforms"))
        (hsPkgs."HsYAML" or (buildDepError "HsYAML"))
        (hsPkgs."doclayout" or (buildDepError "doclayout"))
        (hsPkgs."ipynb" or (buildDepError "ipynb"))
        (hsPkgs."attoparsec" or (buildDepError "attoparsec"))
        (hsPkgs."text-conversions" or (buildDepError "text-conversions"))
        (hsPkgs."emojis" or (buildDepError "emojis"))
      ] ++ (pkgs.lib).optionals (system.isWindows && system.isI386) [
        (hsPkgs."basement" or (buildDepError "basement"))
        (hsPkgs."foundation" or (buildDepError "foundation"))
      ]) ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.4")
        (hsPkgs."base-compat" or (buildDepError "base-compat")))
        ++ (pkgs.lib).optional (!system.isWindows)
        (hsPkgs."unix" or (buildDepError "unix")))
        ++ (pkgs.lib).optional (flags.embed_data_files)
        (hsPkgs."file-embed" or (buildDepError "file-embed"));
      buildable = true;
      modules = ([
        "Text/Pandoc/App/CommandLineOptions"
        "Text/Pandoc/App/FormatHeuristics"
        "Text/Pandoc/App/Opt"
        "Text/Pandoc/App/OutputSettings"
        "Text/Pandoc/Filter/JSON"
        "Text/Pandoc/Filter/Lua"
        "Text/Pandoc/Filter/Path"
        "Text/Pandoc/Readers/Docx/Lists"
        "Text/Pandoc/Readers/Docx/Combine"
        "Text/Pandoc/Readers/Docx/Parse"
        "Text/Pandoc/Readers/Docx/Parse/Styles"
        "Text/Pandoc/Readers/Docx/Util"
        "Text/Pandoc/Readers/Docx/Fields"
        "Text/Pandoc/Readers/LaTeX/Parsing"
        "Text/Pandoc/Readers/LaTeX/Lang"
        "Text/Pandoc/Readers/Odt/Base"
        "Text/Pandoc/Readers/Odt/Namespaces"
        "Text/Pandoc/Readers/Odt/StyleReader"
        "Text/Pandoc/Readers/Odt/ContentReader"
        "Text/Pandoc/Readers/Odt/Generic/Fallible"
        "Text/Pandoc/Readers/Odt/Generic/SetMap"
        "Text/Pandoc/Readers/Odt/Generic/Utils"
        "Text/Pandoc/Readers/Odt/Generic/Namespaces"
        "Text/Pandoc/Readers/Odt/Generic/XMLConverter"
        "Text/Pandoc/Readers/Odt/Arrows/State"
        "Text/Pandoc/Readers/Odt/Arrows/Utils"
        "Text/Pandoc/Readers/Org/BlockStarts"
        "Text/Pandoc/Readers/Org/Blocks"
        "Text/Pandoc/Readers/Org/DocumentTree"
        "Text/Pandoc/Readers/Org/ExportSettings"
        "Text/Pandoc/Readers/Org/Inlines"
        "Text/Pandoc/Readers/Org/Meta"
        "Text/Pandoc/Readers/Org/ParserState"
        "Text/Pandoc/Readers/Org/Parsing"
        "Text/Pandoc/Readers/Org/Shared"
        "Text/Pandoc/Readers/Metadata"
        "Text/Pandoc/Readers/Roff"
        "Text/Pandoc/Writers/Docx/StyleMap"
        "Text/Pandoc/Writers/Roff"
        "Text/Pandoc/Writers/Powerpoint/Presentation"
        "Text/Pandoc/Writers/Powerpoint/Output"
        "Text/Pandoc/Lua/Filter"
        "Text/Pandoc/Lua/Global"
        "Text/Pandoc/Lua/Init"
        "Text/Pandoc/Lua/Marshaling"
        "Text/Pandoc/Lua/Marshaling/AST"
        "Text/Pandoc/Lua/Marshaling/AnyValue"
        "Text/Pandoc/Lua/Marshaling/CommonState"
        "Text/Pandoc/Lua/Marshaling/MediaBag"
        "Text/Pandoc/Lua/Marshaling/ReaderOptions"
        "Text/Pandoc/Lua/Marshaling/Context"
        "Text/Pandoc/Lua/Marshaling/Version"
        "Text/Pandoc/Lua/Module/MediaBag"
        "Text/Pandoc/Lua/Module/Pandoc"
        "Text/Pandoc/Lua/Module/System"
        "Text/Pandoc/Lua/Module/Types"
        "Text/Pandoc/Lua/Module/Utils"
        "Text/Pandoc/Lua/Packages"
        "Text/Pandoc/Lua/Util"
        "Text/Pandoc/Lua/Walk"
        "Text/Pandoc/CSS"
        "Text/Pandoc/CSV"
        "Text/Pandoc/RoffChar"
        "Text/Pandoc/UUID"
        "Text/Pandoc/Translations"
        "Text/Pandoc/Slides"
        "Paths_pandoc"
        "Text/Pandoc"
        "Text/Pandoc/App"
        "Text/Pandoc/Options"
        "Text/Pandoc/Extensions"
        "Text/Pandoc/Shared"
        "Text/Pandoc/MediaBag"
        "Text/Pandoc/Error"
        "Text/Pandoc/Filter"
        "Text/Pandoc/Readers"
        "Text/Pandoc/Readers/HTML"
        "Text/Pandoc/Readers/LaTeX"
        "Text/Pandoc/Readers/LaTeX/Types"
        "Text/Pandoc/Readers/Markdown"
        "Text/Pandoc/Readers/CommonMark"
        "Text/Pandoc/Readers/Creole"
        "Text/Pandoc/Readers/MediaWiki"
        "Text/Pandoc/Readers/Vimwiki"
        "Text/Pandoc/Readers/RST"
        "Text/Pandoc/Readers/Org"
        "Text/Pandoc/Readers/DocBook"
        "Text/Pandoc/Readers/JATS"
        "Text/Pandoc/Readers/Jira"
        "Text/Pandoc/Readers/OPML"
        "Text/Pandoc/Readers/Textile"
        "Text/Pandoc/Readers/Native"
        "Text/Pandoc/Readers/Haddock"
        "Text/Pandoc/Readers/TWiki"
        "Text/Pandoc/Readers/TikiWiki"
        "Text/Pandoc/Readers/Txt2Tags"
        "Text/Pandoc/Readers/Docx"
        "Text/Pandoc/Readers/Odt"
        "Text/Pandoc/Readers/EPUB"
        "Text/Pandoc/Readers/Muse"
        "Text/Pandoc/Readers/Man"
        "Text/Pandoc/Readers/FB2"
        "Text/Pandoc/Readers/DokuWiki"
        "Text/Pandoc/Readers/Ipynb"
        "Text/Pandoc/Writers"
        "Text/Pandoc/Writers/Native"
        "Text/Pandoc/Writers/Docbook"
        "Text/Pandoc/Writers/JATS"
        "Text/Pandoc/Writers/OPML"
        "Text/Pandoc/Writers/HTML"
        "Text/Pandoc/Writers/Ipynb"
        "Text/Pandoc/Writers/ICML"
        "Text/Pandoc/Writers/Jira"
        "Text/Pandoc/Writers/LaTeX"
        "Text/Pandoc/Writers/ConTeXt"
        "Text/Pandoc/Writers/OpenDocument"
        "Text/Pandoc/Writers/Texinfo"
        "Text/Pandoc/Writers/Man"
        "Text/Pandoc/Writers/Ms"
        "Text/Pandoc/Writers/Markdown"
        "Text/Pandoc/Writers/CommonMark"
        "Text/Pandoc/Writers/Haddock"
        "Text/Pandoc/Writers/RST"
        "Text/Pandoc/Writers/Org"
        "Text/Pandoc/Writers/AsciiDoc"
        "Text/Pandoc/Writers/Custom"
        "Text/Pandoc/Writers/Textile"
        "Text/Pandoc/Writers/MediaWiki"
        "Text/Pandoc/Writers/DokuWiki"
        "Text/Pandoc/Writers/XWiki"
        "Text/Pandoc/Writers/ZimWiki"
        "Text/Pandoc/Writers/RTF"
        "Text/Pandoc/Writers/ODT"
        "Text/Pandoc/Writers/Docx"
        "Text/Pandoc/Writers/Powerpoint"
        "Text/Pandoc/Writers/EPUB"
        "Text/Pandoc/Writers/FB2"
        "Text/Pandoc/Writers/TEI"
        "Text/Pandoc/Writers/Muse"
        "Text/Pandoc/Writers/Math"
        "Text/Pandoc/Writers/Shared"
        "Text/Pandoc/Writers/OOXML"
        "Text/Pandoc/Lua"
        "Text/Pandoc/PDF"
        "Text/Pandoc/UTF8"
        "Text/Pandoc/Templates"
        "Text/Pandoc/XML"
        "Text/Pandoc/SelfContained"
        "Text/Pandoc/Highlighting"
        "Text/Pandoc/Logging"
        "Text/Pandoc/Process"
        "Text/Pandoc/MIME"
        "Text/Pandoc/Parsing"
        "Text/Pandoc/Asciify"
        "Text/Pandoc/Emoji"
        "Text/Pandoc/ImageSize"
        "Text/Pandoc/BCP47"
        "Text/Pandoc/Class"
      ] ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.4")
        "Prelude")
        ++ (pkgs.lib).optional (flags.embed_data_files) "Text/Pandoc/Data";
      hsSourceDirs = [ "src" ]
        ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.4")
        "prelude";
    };
    exes = {
      "pandoc" = {
        depends = [
          (hsPkgs."pandoc" or (buildDepError "pandoc"))
          (hsPkgs."base" or (buildDepError "base"))
        ] ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.4")
          (hsPkgs."base-compat" or (buildDepError "base-compat"));
        buildable = true;
        modules = [ "Paths_pandoc" ]
          ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.4")
          "Prelude";
        hsSourceDirs = [ "." ]
          ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.4")
          "prelude";
        mainPath = ((([ "pandoc.hs" ]
          ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.4")
          "") ++ (pkgs.lib).optional (flags.static) "")
          ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).ge "8.2")
          "")
          ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).ge "8.4")
          "";
      };
      "trypandoc" = {
        depends = (pkgs.lib).optionals (flags.trypandoc) [
          (hsPkgs."base" or (buildDepError "base"))
          (hsPkgs."aeson" or (buildDepError "aeson"))
          (hsPkgs."pandoc" or (buildDepError "pandoc"))
          (hsPkgs."text" or (buildDepError "text"))
          (hsPkgs."wai-extra" or (buildDepError "wai-extra"))
          (hsPkgs."wai" or (buildDepError "wai"))
          (hsPkgs."http-types" or (buildDepError "http-types"))
        ] ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.4")
          (hsPkgs."base-compat" or (buildDepError "base-compat"));
        buildable = if flags.trypandoc then true else false;
        modules =
          (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.4")
          "Prelude";
        hsSourceDirs = [ "trypandoc" ]
          ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.4")
          "prelude";
        mainPath = ((([ "trypandoc.hs" ] ++ [ "" ])
          ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.4")
          "")
          ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).ge "8.2")
          "")
          ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).ge "8.4")
          "";
      };
    };
    tests = {
      "test-pandoc" = {
        depends = [
          (hsPkgs."base" or (buildDepError "base"))
          (hsPkgs."pandoc" or (buildDepError "pandoc"))
          (hsPkgs."pandoc-types" or (buildDepError "pandoc-types"))
          (hsPkgs."mtl" or (buildDepError "mtl"))
          (hsPkgs."bytestring" or (buildDepError "bytestring"))
          (hsPkgs."base64-bytestring" or (buildDepError "base64-bytestring"))
          (hsPkgs."text" or (buildDepError "text"))
          (hsPkgs."time" or (buildDepError "time"))
          (hsPkgs."directory" or (buildDepError "directory"))
          (hsPkgs."filepath" or (buildDepError "filepath"))
          (hsPkgs."hslua" or (buildDepError "hslua"))
          (hsPkgs."process" or (buildDepError "process"))
          (hsPkgs."temporary" or (buildDepError "temporary"))
          (hsPkgs."Diff" or (buildDepError "Diff"))
          (hsPkgs."tasty" or (buildDepError "tasty"))
          (hsPkgs."tasty-hunit" or (buildDepError "tasty-hunit"))
          (hsPkgs."tasty-lua" or (buildDepError "tasty-lua"))
          (hsPkgs."tasty-quickcheck" or (buildDepError "tasty-quickcheck"))
          (hsPkgs."tasty-golden" or (buildDepError "tasty-golden"))
          (hsPkgs."QuickCheck" or (buildDepError "QuickCheck"))
          (hsPkgs."containers" or (buildDepError "containers"))
          (hsPkgs."executable-path" or (buildDepError "executable-path"))
          (hsPkgs."zip-archive" or (buildDepError "zip-archive"))
          (hsPkgs."xml" or (buildDepError "xml"))
          (hsPkgs."doctemplates" or (buildDepError "doctemplates"))
          (hsPkgs."Glob" or (buildDepError "Glob"))
        ] ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.4")
          (hsPkgs."base-compat" or (buildDepError "base-compat"));
        buildable = true;
        modules = [
          "Tests/Old"
          "Tests/Command"
          "Tests/Helpers"
          "Tests/Lua"
          "Tests/Lua/Module"
          "Tests/Shared"
          "Tests/Readers/LaTeX"
          "Tests/Readers/HTML"
          "Tests/Readers/JATS"
          "Tests/Readers/Jira"
          "Tests/Readers/Markdown"
          "Tests/Readers/Org"
          "Tests/Readers/Org/Block"
          "Tests/Readers/Org/Block/CodeBlock"
          "Tests/Readers/Org/Block/Figure"
          "Tests/Readers/Org/Block/Header"
          "Tests/Readers/Org/Block/List"
          "Tests/Readers/Org/Block/Table"
          "Tests/Readers/Org/Directive"
          "Tests/Readers/Org/Inline"
          "Tests/Readers/Org/Inline/Citation"
          "Tests/Readers/Org/Inline/Note"
          "Tests/Readers/Org/Inline/Smart"
          "Tests/Readers/Org/Meta"
          "Tests/Readers/Org/Shared"
          "Tests/Readers/RST"
          "Tests/Readers/Docx"
          "Tests/Readers/Odt"
          "Tests/Readers/Txt2Tags"
          "Tests/Readers/EPUB"
          "Tests/Readers/Muse"
          "Tests/Readers/Creole"
          "Tests/Readers/Man"
          "Tests/Readers/FB2"
          "Tests/Readers/DokuWiki"
          "Tests/Writers/Native"
          "Tests/Writers/ConTeXt"
          "Tests/Writers/Docbook"
          "Tests/Writers/HTML"
          "Tests/Writers/JATS"
          "Tests/Writers/Markdown"
          "Tests/Writers/Org"
          "Tests/Writers/Plain"
          "Tests/Writers/AsciiDoc"
          "Tests/Writers/LaTeX"
          "Tests/Writers/Docx"
          "Tests/Writers/RST"
          "Tests/Writers/TEI"
          "Tests/Writers/Muse"
          "Tests/Writers/FB2"
          "Tests/Writers/Powerpoint"
          "Tests/Writers/OOXML"
        ] ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.4")
          "Prelude";
        hsSourceDirs = [ "test" ]
          ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.4")
          "prelude";
        mainPath = [ "test-pandoc.hs" ];
      };
    };
    benchmarks = {
      "weigh-pandoc" = {
        depends = [
          (hsPkgs."pandoc" or (buildDepError "pandoc"))
          (hsPkgs."base" or (buildDepError "base"))
          (hsPkgs."text" or (buildDepError "text"))
          (hsPkgs."weigh" or (buildDepError "weigh"))
          (hsPkgs."mtl" or (buildDepError "mtl"))
        ] ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.4")
          (hsPkgs."base-compat" or (buildDepError "base-compat"));
        buildable = true;
        modules =
          (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.4")
          "Prelude";
        hsSourceDirs = [ "benchmark" ]
          ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.4")
          "prelude";
      };
      "benchmark-pandoc" = {
        depends = [
          (hsPkgs."pandoc" or (buildDepError "pandoc"))
          (hsPkgs."time" or (buildDepError "time"))
          (hsPkgs."bytestring" or (buildDepError "bytestring"))
          (hsPkgs."containers" or (buildDepError "containers"))
          (hsPkgs."base" or (buildDepError "base"))
          (hsPkgs."text" or (buildDepError "text"))
          (hsPkgs."mtl" or (buildDepError "mtl"))
          (hsPkgs."criterion" or (buildDepError "criterion"))
        ] ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.4")
          (hsPkgs."base-compat" or (buildDepError "base-compat"));
        buildable = true;
        modules =
          (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.4")
          "Prelude";
        hsSourceDirs = [ "benchmark" ]
          ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.4")
          "prelude";
      };
    };
  };
} // rec {
  src = (pkgs.lib).mkDefault ../.;
}
