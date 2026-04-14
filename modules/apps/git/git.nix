{pkgs, ...}: {
  programs.git = {
    enable = true;
    settings = {
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
        mergiraf = {
          name = "mergiraf";
          driver = "${pkgs.mergiraf}/bin/mergiraf merge --git %O %A %B -s %S -x %X -y %Y -p %P";
        };
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
    attributes = [
      "*.java merge=mergiraf"
      "*.rs merge=mergiraf"
      "*.go merge=mergiraf"
      "*.js merge=mergiraf"
      "*.jsx merge=mergiraf"
      "*.json merge=mergiraf"
      "*.yml merge=mergiraf"
      "*.yaml merge=mergiraf"
      "*.html merge=mergiraf"
      "*.htm merge=mergiraf"
      "*.xhtml merge=mergiraf"
      "*.xml merge=mergiraf"
      "*.c merge=mergiraf"
      "*.cc merge=mergiraf"
      "*.h merge=mergiraf"
      "*.cpp merge=mergiraf"
      "*.hpp merge=mergiraf"
      "*.cs merge=mergiraf"
      "*.dart merge=mergiraf"
    ];
  };
}
