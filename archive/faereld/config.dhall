{ data_options =
  { data_path = "~/sandbox/autophagy/hraew/hraew/horda/faereld.hord"
  , num_last_objects = 10
  , use_wending = True
  }
, general_areas =
  { BLD =
    { name = "Bouldering"
    , rendering_string = "On {date} I bouldered at {object} for {duration}"
    , use_last_objects = True
    }
  , IRL =
    { name = "Real life engagements (confs/talks/meetups)"
    , rendering_string = "On {date} I was at {object} for {duration}"
    , use_last_objects = False
    }
  , LNG =
    { name = "Languages"
    , rendering_string = "On {date} I studied {object} for {duration}"
    , use_last_objects = True
    }
  , LRN =
    { name = "Education"
    , rendering_string = "On {date} I studied {object} for {duration}"
    , use_last_objects = True
    }
  , RDG =
    { name = "Reading"
    , rendering_string = "On {date} I read {object} for {duration}"
    , use_last_objects = True
    }
  , TSK =
    { name = "Tasks"
    , rendering_string = "On {date} I worked on {object} for {duration}"
    , use_last_objects = False
    }
  , WRI =
    { name = "Writing"
    , rendering_string = "On {date} I wrote on {object} for {duration}"
    , use_last_objects = True
    }
  }
, project_areas =
  { DES =
    { name = "Design"
    , rendering_string =
        "On {date} I worked on {object} ({area_name}) for {duration} - {purpose}"
    }
  , DEV =
    { name = "Development"
    , rendering_string =
        "On {date} I worked on {object} ({area_name}) for {duration} - {purpose}"
    }
  , DOC =
    { name = "Documentation"
    , rendering_string =
        "On {date} I worked on {object} ({area_name}) for {duration} - {purpose}"
    }
  , RES =
    { name = "Research"
    , rendering_string =
        "On {date} I worked on {object} ({area_name}) for {duration} - {purpose}"
    }
  , TST =
    { name = "Testing"
    , rendering_string =
        "On {date} I worked on {object} ({area_name}) for {duration} - {purpose}"
    }
  }
, projects =
  { aerende =
    { desc = "Post it notes"
    , link = "https://github.com/Autophagy/aerende"
    , name = "Ærende"
    }
  , ametan =
    { desc = "An Android app for scrum estimation planning poker."
    , link = "https://github.com/Autophagy/ametan"
    , name = "Ametan"
    }
  , antimber =
    { desc = "A set of configuration files for Arch Linux."
    , link = "https://github.com/Autophagy/antimber"
    , name = "Antimber"
    }
  , black =
    { desc = "The uncompromising Python code formatter"
    , link = "https://github.com/ambv/black"
    , name = "Black"
    }
  , byrgen = { desc = "Ghost Theme", name = "Byrgen" }
  , datarum =
    { desc = "A calendar system based on the French Republican Calendar."
    , link = "https://github.com/Autophagy/datarum"
    , name = "Datárum"
    }
  , faereld =
    { desc = "A time tracking tool."
    , link = "https://github.com/Autophagy/faereld"
    , name = "Færeld"
    }
  , forebodere = { desc = "Discord quote bot", name = "Forebodere" }
  , geard = { desc = "Indoor Herb Garden", name = "Geard" }
  , getheode =
    { desc = "A tool for language construction."
    , link = "https://github.com/Autophagy/getheode"
    , name = "Geþeóde"
    }
  , hlaf = { desc = "Meal Planning App", name = "Hláf" }
  , hraew =
    { desc = "A project information & documentation engine."
    , link = "https://github.com/Autophagy/hraew"
    , name = "Hrǽw"
    }
  , hwaete =
    { desc = "A project to document my bread baking."
    , link = "https://github.com/Autophagy/hwaete"
    , name = "Hwǣte"
    }
  , insegel =
    { desc = "A theme for the Sphinx documentation engine."
    , link = "https://github.com/Autophagy/insegel"
    , name = "Insegel"
    }
  , northanwind = { desc = "Ventilation fan", name = "Norþanwind" }
  , regn =
    { desc = "Weather station"
    , link = "https://github.com/Autophagy/regn"
    , name = "Regn"
    }
  , scieldas =
    { desc = "A service to provide metadata badges for Open Source projects."
    , link = "https://github.com/Autophagy/scieldas"
    , name = "Scieldas"
    }
  , stypelas = { desc = "Architecture modelling in Blender", name = "Stýpelas" }
  , tid =
    { desc = "Cooking tool"
    , link = "https://github.com/autophagy/tid"
    , name = "Tíd"
    }
  , twitter-bg-restorer =
    { desc = "Firefox/Chrome plugin", name = "Twitter Background Restorer" }
  , wisdomhord =
    { desc = "A flat file database tool for internal project use."
    , link = "https://github.com/Autophagy/wisdomhord"
    , name = "Wísdómhord"
    }
  }
, summary_options =
  { exclude_from_entry_time_distribution = [ "IRL" ]
  , exclude_from_total_time = [ "TSK" ]
  , max_graph_width = 100
  }
}
