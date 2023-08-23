// NOTES

#let speaker-note(text) = {
  let text = if type(text) == "string" {
    text
  } else if type(text) == "content" and text.func() == raw {
    text.text.trim()
  } else {
    panic("A note must either be a string or a raw block")
  }
  [ #metadata(text) <pdfpc-note> ]
}
