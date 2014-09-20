module Axioms where

import Syntax

data Rule = Rule { expression :: Expr,
                   mP :: Int,
                   current :: String }

ax1 :: Expr
ax1 = BinOp Impl (Statement "A") (BinOp Impl (Statement "B") (Statement "A"))
r1 :: Rule
r1 = Rule ax1 (-1) ""

ax2 :: Expr
ax2 = BinOp Impl (BinOp Impl (Statement "A") (Statement "B")) (BinOp Impl (BinOp Impl (Statement "A") (BinOp Impl (Statement "B") (Statement "C"))) (BinOp Impl (Statement "A") (Statement "C")))
r2 :: Rule
r2 = Rule ax2 (-1) ""

ax3 :: Expr
ax3 = BinOp Impl (Statement "A") (BinOp Impl (Statement "B") (BinOp And (Statement "A") (Statement "B")))
r3 :: Rule
r3 = Rule ax3 (-1) ""

ax4 :: Expr
ax4 = BinOp Impl (BinOp And (Statement "A") (Statement "B")) (Statement "A")
r4 :: Rule
r4 = Rule ax4 (-1) ""

ax5 :: Expr
ax5 = BinOp Impl (BinOp And (Statement "A") (Statement "B")) (Statement "B")
r5 :: Rule
r5 = Rule ax5 (-1) ""

ax6 :: Expr
ax6 = BinOp Impl (Statement "A") (BinOp Or (Statement "A") (Statement "B"))
r6 :: Rule
r6 = Rule ax6 (-1) ""

ax7 :: Expr
ax7 = BinOp Impl (Statement "B") (BinOp Or (Statement "A") (Statement "B"))
r7 :: Rule
r7 = Rule ax7 (-1) ""

ax8 :: Expr
ax8 = BinOp Impl (BinOp Impl (Statement "A") (Statement "C")) (BinOp Impl (BinOp Impl (Statement "B") (Statement "C")) (BinOp Impl (BinOp Or (Statement "A") (Statement "B")) (Statement "C")))
r8 :: Rule
r8 = Rule ax8 (-1) ""

ax9 :: Expr
ax9 = BinOp Impl (BinOp Impl (Statement "A") (Statement "B")) (BinOp Impl (BinOp Impl (Statement "A") (UnOp LNot (Statement "B"))) (UnOp LNot (Statement "A")))
r9 :: Rule
r9 = Rule ax9 (-1) ""

ax10 :: Expr
ax10 = BinOp Impl (UnOp LNot (UnOp LNot (Statement "A"))) (Statement "A")
r10 :: Rule
r10 = Rule ax10 (-1) ""
