function Image(elem)
  elem.src = elem.src:gsub(".svg", ".pdf")
  return elem
end