{ bash, wgnamed, wireguard-tools }:
wireguard-tools.overrideAttrs (p: {
  pname = "${p.pname}-name";
  buildInputs = p.buildInputs ++ [ wgnamed ];
  postFixup =
    ''
      mv "$out/bin/wg" "$out/bin/wg-original"

      ####
      cat > $out/bin/wg <<EOF
      #!${bash}/bin/bash
      excludeWord=( interfaces -h --help )

      if [[ "\$1" == "show" ]]; then
        ################
        # dont run on
        # wg show interfaces
        # wg show (.+) (.+)
        if [[ " \''${excludeWord[*]} " =~ " \$2 " ]] || [[ "\$3" != "" ]]; then
          $out/bin/wg-original \''${@:1}
          exit $?
        fi
        ################

        PATH=$out/bin PROGRAM="wg-original" ${wgnamed}/bin/wgnamed \''${@:2}
      else
        $out/bin/wg-original \''${@:1}
      fi
      EOF
      ####

      chmod +x "$out/bin/wg"
    '';
})
