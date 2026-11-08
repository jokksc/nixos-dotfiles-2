{ lib, ... }:
let
  gv = lib.hm.gvariant;

  # a{sv}: dictionary whose values are variants (a pipeline, an effect, params...)
  dict = attrs:
    gv.mkArray "{sv}" (
      lib.mapAttrsToList (name: value: gv.mkDictionaryEntry [ name (gv.mkVariant value) ]) attrs
    );

  # one effect of a pipeline, e.g. { type = "dual_kawase_blur"; id = "..."; params = {...}; }
  effect = { type, id, params ? { } }:
    gv.mkVariant (dict {
      inherit type id;
      params = dict params;
    });

  # a pipeline: a name plus the (ordered) list of effects it applies
  pipeline = { name, effects }:
    dict {
      inherit name;
      effects = gv.mkArray "v" effects;
    };

  # the whole pipelines key (a{sa{sv}})
  pipelines = attrs:
    gv.mkArray "{sa{sv}}" (
      lib.mapAttrsToList (name: value: gv.mkDictionaryEntry [ name (pipeline value) ]) attrs
    );
in
{
  dconf.settings."org/gnome/shell/extensions/blur-my-shell" = {
    pipelines = pipelines {
      pipeline_default = {
        name = "Default";
        effects = [
          (effect {
            type = "dual_kawase_blur";
            id = "effect_000000000000";
            params = {
              unscaled_radius = 30;
              brightness = 0.6;
            };
          })
        ];
      };

      pipeline_default_rounded = {
        name = "Default rounded";
        effects = [
          (effect {
            type = "dual_kawase_blur";
            id = "effect_000000000001";
            params = {
              unscaled_radius = 30;
              brightness = 0.6;
            };
          })
        ];
      };

      pipeline_bec5060e-2dfb-4d59-ab23-6ef6d6b2f48f = {
        name = "Liquid Glass";
        effects = [
          (effect {
            type = "refraction";
            id = "effect_35786146771953";
            params = {
              blur_radius = 10;
            };
          })
        ];
      };

      pipeline_migrated_dynamic_blur = {
        name = "Migrated dynamic blur";
        effects = [
          (effect {
            type = "dual_kawase_blur";
            id = "effect_migrated_dynamic_blur";
            params = {
              unscaled_radius = 60;
              brightness = 0.6;
            };
          })
        ];
      };
    };
  };
}
