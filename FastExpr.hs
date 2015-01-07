module FastExpr where

import Syntax

import qualified Data.ByteString.Char8 as B

showBinop :: BinOpType -> B.ByteString
showBinop b =
    case b of
      Impl -> B.pack "->"
      Or  -> B.pack "|"
      And  -> B.pack "&"

showNot :: B.ByteString
showNot = B.pack "!"

showExprFast :: Expr -> B.ByteString
showExprFast e =
    case e of
      Statement s -> B.pack s
      BinOp t a b -> B.concat [
                       B.pack "(",
                       showExprFast a,
                       showBinop t,
                       showExprFast b,
                       B.pack ")"
                      ]
      UnOp _ a    -> B.append showNot $ showExprFast a
