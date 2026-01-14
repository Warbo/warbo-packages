{ snes-launcher }:
builtins.mapAttrs (name: sha256: snes-launcher { inherit name sha256; }) {
  "Alfred Chicken" = "sha256-pLHhJbQhxaWOL9c+3E1Ysx16WWwH3uJjxWXwDucSIj8=";
  ChronoTrigger = "sha256-oFWLEDw81x1/W7HH3GCoEOGX8/CuGtT5Cr46oVLz1bA=";
  "Donkey Kong Country" = "sha256-+oys9bv8Oe5ruqVXrfiRM9YNQvbPnh2zDVo2pGn3TRU=";
  "Donkey Kong Country 2" = "sha256-NUIamvndARtAuR95IZKvn5nJMgHY05QCa9+0LL8thjM=";
  "Earthworm Jim" = "sha256-SpbzwKdpSh2CNeK/A7WD7S6ZSI0dwOJmkdsAP9Ixkfc=";
  "Final Fantasy 6" = "sha256-CdBOeV1tvmuS1aJdBqGw94SW6D+kGh2+x9OgReFP9vM=";
  "James Pond 3" = "sha256-Lscayk78N5G2s+ZZVt8+r9KkbiI9Xqca6tB9MMpItsk=";
  "The Lion King" = "sha256-iW4JoNJL/sBBKqddEhBjsBUVOnVO1UL3231mNmtVXeQ=";
  "Mortal Kombat" = "sha256-RwPLBxYRh0sNnpVV8QInjjPdSUICh13JlKIyApFIv2c=";
  "Mortal Kombat 2" = "sha256-GdKzIvQFf42UKNbX7to1FKguRs1UMfCPcCII+yqvW6Y=";
  "Mortal Kombat 3" = "sha256-t/pLeVkOze8tAwO1y8zx4aOvMfyiiWUqy9s9U4ETfyQ=";
  "Mr Nutz" = "sha256-QYA4BdKMrYhzApxLZIzG3XUDt6M6+o/1hENKlw3J2ME=";
  Oscar = "sha256-nvH1aza05fWcqiSC2QXYXqjvdGdMRl+dq6flRSDv1oM=";
  "Primal Rage" = "sha256-F0SofUgXvgeUjhs3tZxN5JyF5q7Cz0mHnHuWSdGx/JA=";
  Starwing = "sha256-VTlArUsLvPN1zyoG8JK0T82IDbgggoyMkAxM2dT1dT8=";
  "Super Mario Kart" = "sha256-KtqJGWiAh75gpqSMrOj4d63WDEXS5dCeJEL6pVvmKkk=";
  "Super Mario World 2" = "sha256-m0lXRmeYu9tbQ6RQu7YLJZGugdlbiRQw9i1TymLovHs=";
  "Super Star Wars" = "sha256-EAln652+eFeuIz0XedR6HrBfaOTYW4n/5xhIEeX4AfQ=";
  "Super Star Wars Return Of The Jedi" =
    "sha256-kpRjWO5PvFyx34Gibr0yPC9OjMdqzQOOEZG4qjGtHCQ=";
  "Super Star Wars The Empire Strikes Back" =
    "sha256-JvzrKse6SLO17nK7cHlACKgbmMvbgQli/+l3UXjTZSw=";
  "Teenage Mutant Ninja Turtles 4" =
    "sha256-W4LN1vLaVvQ2gNalAh+uvi4GA20wYCwaeReqQUz4tfQ=";
}
