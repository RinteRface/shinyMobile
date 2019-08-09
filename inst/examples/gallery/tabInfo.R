tabInfo <- f7Tab(
  tabName = "Popups",
  icon = f7Icon("info_round_fill"),

  f7Align(
    side = "center",
    h1("miniUI 2.0 brings interesting popups windows")
  ),

  # popup
  f7BlockTitle(title = "f7Popup") %>% f7Align(side = "center"),
  f7Popup(
    id = "popup1",
    label = "Open",
    title = "My first popup",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
         Quisque ac diam ac quam euismod porta vel a nunc. Quisque sodales
         scelerisque est, at porta justo cursus ac"
  ),
  br(),


  # sheet
  f7BlockTitle(title = "f7Sheet") %>% f7Align(side = "center"),
  f7Sheet(
    id = "sheet1",
    label = "More",
    orientation = "bottom",
    swipeToStep = TRUE,
    "Lorem ipsum dolor sit amet,
    consectetur adipiscing elit. Duo Reges:
    constructio interrete. An tu me de L.
    Quae diligentissime contra Aristonem
    dicuntur a Chryippo. Magni enim aestimabat
    pecuniam non modo non contra leges, sed
    etiam legibus partam. Eademne, quae restincta
    siti? Indicant pueri, in quibus ut in
    speculis natura cernitur. Cupit enim
    dícere nihil posse ad beatam vitam deesse
    sapienti. Qui autem de summo bono dissentit de tota
    philosophiae ratione dissentit. A mene tu? Quid
    ad utilitatem tantae pecuniae?

    Quarum ambarum rerum cum medicinam pollicetur,
    luxuriae licentiam pollicetur. Itaque rursus eadem
    ratione, qua sum paulo ante usus, haerebitis.
    Possumusne ergo in vita summum bonum dicere, cum
    id ne in cena quidem posse videamur? Et si
    turpitudinem fugimus in statu et motu corporis,
    quid est cur pulchritudinem non sequamur? Ratio
    enim nostra consentit, pugnat oratio. Maximas
    vero virtutes iacere omnis necesse est voluptate
    dominante. Quam illa ardentis amores excitaret sui!
    Cur tandem? Cur igitur easdem res, inquam,
    Peripateticis dicentibus verbum nullum est, quod
    non intellegatur? Atqui perspicuum est hominem e
    corpore animoque constare, cum primae sint animi
    partes, secundae corporis."
  ),

  br(),
  # notifications
  f7BlockTitle(title = "Notifications") %>% f7Align("center"),

  f7Segment(
    container = "segment",
    f7Button(inputId = "goNotif1", "Open notification 1", color = "orange"),
    f7Button(inputId = "goNotif2", "Open notification 2", color = "purple"),
    f7Button(inputId = "goNotif3", "Open notification 3")
  )

)
