#import "@preview/acrostiche:0.7.0": *

// --- Acronyms ---
// ================
#let short(str) = strong(acr(str))
#let shorts(str) = strong(acrpl(str))
#let abb(str) = strong(ref(str))

// --- Zitieren --- 
// ================
// Direktes Zitat
#let zitat(key, s: none) = {
  if s != none {
    [(#cite(key, form: "prose"), S. #s)]
  } else {
    [(#cite(key, form: "prose"))]
  }
}

// Indirektes Zitat 
#let vgl(key, s: none) = {
  if s != none {
    [(vgl. #cite(key, form: "prose"), S. #s)]
  } else {
    [(vgl. #cite(key, form: "prose"))]
  }
}

// Fließtext-Zitat 
#let imtext(key) = {
  [#cite(key, form: "author") (#cite(key, form: "year"))]
}
