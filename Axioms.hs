module Axioms where

import Syntax

axioms :: [Expr]
axioms = [ax1, ax2, ax3, ax4, ax5, ax6, ax7, ax8, ax9, ax10]

ax1 :: Expr
ax1 = BinOp Impl (Statement "A") (BinOp Impl (Statement "B") (Statement "A"))

ax2 :: Expr
ax2 = BinOp Impl (BinOp Impl (Statement "A") (Statement "B")) (BinOp Impl (BinOp Impl (Statement "A") (BinOp Impl (Statement "B") (Statement "C"))) (BinOp Impl (Statement "A") (Statement "C")))

ax3 :: Expr
ax3 = BinOp Impl (Statement "A") (BinOp Impl (Statement "B") (BinOp And (Statement "A") (Statement "B")))

ax4 :: Expr
ax4 = BinOp Impl (BinOp And (Statement "A") (Statement "B")) (Statement "A")

ax5 :: Expr
ax5 = BinOp Impl (BinOp And (Statement "A") (Statement "B")) (Statement "B")

ax6 :: Expr
ax6 = BinOp Impl (Statement "A") (BinOp Or (Statement "A") (Statement "B"))

ax7 :: Expr
ax7 = BinOp Impl (Statement "B") (BinOp Or (Statement "A") (Statement "B"))

ax8 :: Expr
ax8 = BinOp Impl (BinOp Impl (Statement "A") (Statement "C")) (BinOp Impl (BinOp Impl (Statement "B") (Statement "C")) (BinOp Impl (BinOp Or (Statement "A") (Statement "B")) (Statement "C")))

ax9 :: Expr
ax9 = BinOp Impl (BinOp Impl (Statement "A") (Statement "B")) (BinOp Impl (BinOp Impl (Statement "A") (UnOp LNot (Statement "B"))) (UnOp LNot (Statement "A")))

ax10 :: Expr
ax10 = BinOp Impl (UnOp LNot (UnOp LNot (Statement "A"))) (Statement "A")
