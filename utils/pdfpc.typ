#let pdfpc_metadata = state("polylux_pdfpc_metadata", (
  pdfpcFormat: 2,
  pages: ()
));

#let set_or_fail(key, value) = {
  pdfpc_metadata.update(m=>{
    assert(key not in m.keys(), message: "The key "+key+" can only be set once.");
    m.insert(key, value);
    m
  })
}

#let register_page(idx, logicalSlide, overlay) = {
  pdfpc_metadata.update(m=>{
    let entry = (
      idx: idx,
      label: str(logicalSlide),
      overlay: overlay
    );

    if(overlay>0) {
      entry.forcedOverlay = true;
    }

    m.pages.push(entry);
    m
  })
}

#let meta_out() = {
  pdfpc_metadata.display(m=>[#metadata(m)<pdfpc>]);
}

#let speaker-note(text) = {
  let text = if type(text) == "string" {
    text
  } else if type(text) == "content" and text.func() == raw {
    text.text.trim()
  } else {
    panic("A note must either be a string or a raw block")
  }
  pdfpc_metadata.update(m=>{
    let page = m.pages.at(-1);
    page.insert("note", page.at("note", default: "")+text);
    m
  })
}

#let end-slide = {
  pdfpc_metadata.display(m=>set_or_fail("endSlide", m.pages.at(-1).label))
  
}

#let save-slide = {
  pdfpc_metadata.display(m=>set_or_fail("saveSlide", m.pages.at(-1).label))
}

#let hidden-slide = {
  pdfpc_metadata.update(m=>{
    m.pages.at(-1).hidden=true;
    m
  })
}

#let config(
  duration-minutes: none,
  start-time: none,
  end-time: none,
  last-minutes: none,
  note-font-size: none,
  disable-markdown: false,
  default-transition: none,
) = {
  if duration-minutes != none {
    set_or_fail("duration", duration-minutes);
  }

  let _time-config(time, msg-name, tag-name) = {
    let time = if type(time) == "datetime" {
      time.display("[hour padding:zero repr:24]:[minute padding:zero]")
    } else if type(time) == "string" {
      time
    } else {
      panic(msg-name + " must be either a datetime or a string in the HH:MM format.")
    }
    set_or_fail(tag-name, time);
  }

  if start-time != none {
    _time-config(start-time, "Start time", "startTime")
  }

  if end-time != none {
    _time-config(end-time, "End time", "endTime")
  }

  if last-minutes != none {
    set_or_fail("lastMinutes", last_minutes);
  }

  if note-font-size != none {
    set_or_fail("noteFontSize", note-font-size);
  }

  set_or_fail("disableMarkdown", disable-markdown);

  if default-transition != none {
    let dir-to-angle(dir) = if dir == ltr {
      "0"
    } else if dir == rtl {
      "180"
    } else if dir == ttb {
      "90"
    } else if dir == btt {
      "270"
    } else {
      panic("angle must be a direction (ltr, rtl, ttb, or btt)")
    }

    let transition-str = (
      default-transition.at("type", default: "replace")
      + ":" +
      str(default-transition.at("duration-seconds", default: 1))
      + ":" +
      dir-to-angle(default-transition.at("angle", default: rtl))
      + ":" +
      default-transition.at("alignment", default: "horizontal")
      + ":" +
      default-transition.at("direction", default: "outward")
    )

    set_or_fail("defaultTransition", transition-str);
  }
}
