{
  programs.git = {
    enable = true;
    config = {
      user = {
        email = "m4kai410@gmail.com";
        name = "Makai";
      };
      url = {
        "https://github.com/" = {
          insteadOf = [
            "gh:"
            "github:"
          ];
        };
      };
      diff = {
        algorithm = "patience";
        colorMoved = "zebra";
      };
      color = {
        ui = "auto";
        branch = "auto";
        diff = "auto";
        status = "auto";
        showbranch = "auto";
      };
      merge = {
        tool = "hx";
        renamelimit = 20000;
      };
      mergetool = {
        prompt = false;
      };
      pull = {
        rebase = true;
      };
      rebase = {
        autoSquash = true;
        autoStash = true;
        updateRefs = true;
      };
      core = {
        autocrlf = "input";
      };
      credential = {
        helper = "cache";
      };
      init = {
        defaultBranch = "main";
      };
      rerere = {
        enabled = true;
        autoupdate = true;
      };
      fetch = {
        prune = true;
      };
      push = {
        autoSetupRemote = true;
      };
      column = {
        ui = "auto";
      };
    };
  };
}
