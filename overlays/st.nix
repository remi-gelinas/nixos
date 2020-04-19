final: prev: {
  st = let
    # Alpha patch
    alpha = prev.fetchpatch {
      url = "https://st.suckless.org/patches/alpha/st-alpha-0.8.2.diff";
      sha256 = "158k93bbgrmcajfxvkrzfl65lmqgj6rk6kn8yl6nwk183hhf5qd4";
    };

    # Ligature patch with alpha patch compatibility
    ligatures-alpha = prev.fetchpatch {
      url = "https://github.com/cog1to/st-ligatures/raw/master/st-ligatures-alpha-20200406-28ad288.diff";
      sha256 = "0n7irfnhh686qwjdm71fk0c5x1qjklaflss34jpvcr7pjcvs2php";
    };
  in
    prev.st.override {
      patches = [ alpha ligatures-alpha ];
      extraLibs = [ prev.harfbuzz ];
    };
}
