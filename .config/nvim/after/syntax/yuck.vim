" Override for better backtick handling in yuck files
syn clear yuckString
syn region yuckString start=/"/ end=/"/ contains=yuckInterpolation
syn region yuckString start=/'/ end=/'/ contains=yuckInterpolation  
syn region yuckString start=/`/ end=/`/ contains=yuckInterpolation

" Handle interpolation inside strings
syn match yuckInterpolation /\${[^}]*}/ contained

hi def link yuckString String
hi def link yuckInterpolation Special
