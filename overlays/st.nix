final: prev: {
  st = let
    # Alpha patch
    alpha = prev.fetchPatch {
      url = "https://st.suckless.org/patches/alpha/st-alpha-0.8.2.diff";
      sha256 = "158k93bbgrmcajfxvkrzfl65lmqgj6rk6kn8yl6nwk183hhf5qd4";
    };

    # Ligature patch with alpha patch compatibility
    ligatures-alpha = prev.fetchPatch {
      url = "https://github.com/cog1to/st-ligatures/raw/master/st-ligatures-alpha-scrollback-20200406-28ad288.diff";
      sha256 = "1lvvlx2xh6dgr363hg9hfd6nr87nqksrlhkfjdaz6k86ahcn7srf";
    };

    # Nord theme patch
    nord = prev.fetchpatch {
      url = "https://st.suckless.org/patches/nordtheme/st-nordtheme-0.8.2.diff";
      sha256 = "03b709p3mywydzsi5gx8j24krb63kzm5if4dyqq7s0ahh85qiv7n";
    };
  in
    prev.st.override {
      patches = [ alpha, ligatures-alpha, nord ];
    };
}
