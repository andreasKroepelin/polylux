#let speaker-note(text) = {
  let text = if type(text) == "string" {
    text
  } else if type(text) == "content" and text.func() == raw {
    text.text.trim()
  } else {
    panic("A note must either be a string or a raw block")
  }
  [ #metadata((t: "Note", v: text)) <pdfpc> ]
}

#let end-slide = [
  #metadata((t: "EndSlide")) <pdfpc>
]

#let save-slide = [
  #metadata((t: "SaveSlide")) <pdfpc>
]

#let hidden-slide = [
  #metadata((t: "HiddenSlide")) <pdfpc>
]

#let duration-minutes(minutes) = [
  #metadata((t: "Duration", v: minutes)) <pdfpc>
]

#let _time-config(time, msg-name, tag-name) = {
  let time = if type(time) == "datetime" {
    time.display("[hour padding:zero repr:24]:[minute padding:zero]")
  } else if type(time) == "string" {
    time
  } else {
    panic(msg-name + " must be either a datetime or a string in the HH:MM format.")
  }

  [ #metadata((t: tag-name, v: time)) <pdfpc> ]
}

#let start-time(time) = {
  _time-config(time, "Start time", "StartTime")
}

#let end-time(time) = {
  _time-config(time, "End time", "EndTime")
}

#let last-minutes(minutes) = [
  #metadata((t: "LastMinutes", v: minutes)) <pdfpc>
]

#let note-font-size(font-size) = [
  #metadata((t: "NoteFontSize", v: font-size)) <pdfpc>
]

#let disable-markdown(disabled) = [
  #metadata((t: "DisableMarkdown", v: disabled)) <pdfpc>
]

#let default-transition(default) = [
  #metadata((t: "DefaultTransition", v: default)) <pdfpc>
]
