cifrar :: Int -> String -> String
cifrar n s = [
    if fromEnum c > 64 && fromEnum c < 91 then toEnum (mod (fromEnum c - 65 + n) 26 + 65) else
    if fromEnum c > 96 && fromEnum c < 123 then toEnum (mod (fromEnum c - 96 + n) 26 + 96) else c | c <- s]
