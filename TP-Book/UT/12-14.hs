data SyntaxTree a = Const a | Unary (a -> a) (SyntaxTree a) | Binary (a -> a -> a) (SyntaxTree a) (SyntaxTree a)

countConsts :: SyntaxTree a -> Int 
countConsts (Const _) = 1
countConsts (Unary _ st) = countConsts st
countConsts (Binary _ st1 st2) = countConsts st1 + countConsts st2

compute :: SyntaxTree a -> a
compute (Const val) = val
compute (Unary f st) = f $ compute st
compute (Binary f st1 st2) = f (compute st1) $ compute st2