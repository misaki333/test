$ ->
  $("#plan_spot_field").autocomplete
    source: (req, res) ->
      $.ajax
        url: "/plans/autocomplete_spot/" + encodeURIComponent(req.term) + ".json",
        dataType: "json",
        success: (data) ->
          res(data)
    ,
    autoFocus: true,
    delay: 300,
    minLength: 2

