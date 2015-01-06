{-# OPTIONS_GHC -w #-}
module Syntax where
import Lexer

-- parser produced by Happy Version 1.18.10

data HappyAbsSyn t5 t6 t7 t8 t9 t10
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8
	| HappyAbsSyn9 t9
	| HappyAbsSyn10 t10

action_0 (11) = happyShift action_6
action_0 (14) = happyShift action_7
action_0 (16) = happyShift action_8
action_0 (5) = happyGoto action_10
action_0 (6) = happyGoto action_3
action_0 (7) = happyGoto action_4
action_0 (10) = happyGoto action_5
action_0 _ = happyFail

action_1 (11) = happyShift action_6
action_1 (14) = happyShift action_7
action_1 (16) = happyShift action_8
action_1 (10) = happyGoto action_9
action_1 _ = happyFail

action_2 (11) = happyShift action_6
action_2 (14) = happyShift action_7
action_2 (16) = happyShift action_8
action_2 (6) = happyGoto action_3
action_2 (7) = happyGoto action_4
action_2 (10) = happyGoto action_5
action_2 _ = happyFail

action_3 (20) = happyShift action_17
action_3 _ = happyFail

action_4 (19) = happyShift action_16
action_4 _ = happyReduce_3

action_5 (12) = happyShift action_11
action_5 (13) = happyShift action_12
action_5 (15) = happyShift action_13
action_5 _ = happyReduce_4

action_6 _ = happyReduce_14

action_7 (11) = happyShift action_6
action_7 (14) = happyShift action_7
action_7 (16) = happyShift action_8
action_7 (10) = happyGoto action_15
action_7 _ = happyFail

action_8 (11) = happyShift action_6
action_8 (14) = happyShift action_7
action_8 (16) = happyShift action_8
action_8 (10) = happyGoto action_14
action_8 _ = happyFail

action_9 (12) = happyShift action_11
action_9 (13) = happyShift action_12
action_9 (15) = happyShift action_13
action_9 (21) = happyAccept
action_9 _ = happyFail

action_10 (21) = happyAccept
action_10 _ = happyFail

action_11 (11) = happyShift action_6
action_11 (14) = happyShift action_7
action_11 (16) = happyShift action_8
action_11 (10) = happyGoto action_23
action_11 _ = happyFail

action_12 (11) = happyShift action_6
action_12 (14) = happyShift action_7
action_12 (16) = happyShift action_8
action_12 (10) = happyGoto action_22
action_12 _ = happyFail

action_13 (11) = happyShift action_6
action_13 (14) = happyShift action_7
action_13 (16) = happyShift action_8
action_13 (10) = happyGoto action_21
action_13 _ = happyFail

action_14 (12) = happyShift action_11
action_14 (13) = happyShift action_12
action_14 (15) = happyShift action_13
action_14 (17) = happyShift action_20
action_14 _ = happyFail

action_15 _ = happyReduce_12

action_16 (11) = happyShift action_6
action_16 (14) = happyShift action_7
action_16 (16) = happyShift action_8
action_16 (10) = happyGoto action_19
action_16 _ = happyFail

action_17 (11) = happyShift action_6
action_17 (14) = happyShift action_7
action_17 (16) = happyShift action_8
action_17 (10) = happyGoto action_18
action_17 _ = happyFail

action_18 (12) = happyShift action_11
action_18 (13) = happyShift action_12
action_18 (15) = happyShift action_13
action_18 (18) = happyShift action_24
action_18 _ = happyFail

action_19 (12) = happyShift action_11
action_19 (13) = happyShift action_12
action_19 (15) = happyShift action_13
action_19 _ = happyReduce_5

action_20 _ = happyReduce_13

action_21 (12) = happyShift action_11
action_21 (13) = happyShift action_12
action_21 (15) = happyShift action_13
action_21 _ = happyReduce_11

action_22 _ = happyReduce_9

action_23 (13) = happyShift action_12
action_23 _ = happyReduce_10

action_24 (11) = happyShift action_6
action_24 (14) = happyShift action_7
action_24 (16) = happyShift action_8
action_24 (8) = happyGoto action_25
action_24 (9) = happyGoto action_26
action_24 (10) = happyGoto action_27
action_24 _ = happyFail

action_25 _ = happyReduce_2

action_26 (11) = happyShift action_6
action_26 (14) = happyShift action_7
action_26 (16) = happyShift action_8
action_26 (10) = happyGoto action_29
action_26 _ = happyReduce_6

action_27 (12) = happyShift action_11
action_27 (13) = happyShift action_12
action_27 (15) = happyShift action_13
action_27 (18) = happyShift action_28
action_27 _ = happyFail

action_28 _ = happyReduce_7

action_29 (12) = happyShift action_11
action_29 (13) = happyShift action_12
action_29 (15) = happyShift action_13
action_29 (18) = happyShift action_30
action_29 _ = happyFail

action_30 _ = happyReduce_8

happyReduce_2 = happyReduce 5 5 happyReduction_2
happyReduction_2 ((HappyAbsSyn8  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn10  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (DeductionProof happy_var_3 happy_var_1 happy_var_5
	) `HappyStk` happyRest

happyReduce_3 = happySpecReduce_1  6 happyReduction_3
happyReduction_3 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn6
		 (reverse happy_var_1
	)
happyReduction_3 _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_1  7 happyReduction_4
happyReduction_4 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn7
		 ([happy_var_1]
	)
happyReduction_4 _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_3  7 happyReduction_5
happyReduction_5 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_3 : happy_var_1
	)
happyReduction_5 _ _ _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_1  8 happyReduction_6
happyReduction_6 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn8
		 (reverse happy_var_1
	)
happyReduction_6 _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_2  9 happyReduction_7
happyReduction_7 _
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn9
		 ([happy_var_1]
	)
happyReduction_7 _ _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_3  9 happyReduction_8
happyReduction_8 _
	(HappyAbsSyn10  happy_var_2)
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (happy_var_2 : happy_var_1
	)
happyReduction_8 _ _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_3  10 happyReduction_9
happyReduction_9 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (BinOp And happy_var_1 happy_var_3
	)
happyReduction_9 _ _ _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_3  10 happyReduction_10
happyReduction_10 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (BinOp Or happy_var_1 happy_var_3
	)
happyReduction_10 _ _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_3  10 happyReduction_11
happyReduction_11 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (BinOp Impl happy_var_1 happy_var_3
	)
happyReduction_11 _ _ _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_2  10 happyReduction_12
happyReduction_12 (HappyAbsSyn10  happy_var_2)
	_
	 =  HappyAbsSyn10
		 (UnOp LNot happy_var_2
	)
happyReduction_12 _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_3  10 happyReduction_13
happyReduction_13 _
	(HappyAbsSyn10  happy_var_2)
	_
	 =  HappyAbsSyn10
		 (happy_var_2
	)
happyReduction_13 _ _ _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_1  10 happyReduction_14
happyReduction_14 (HappyTerminal (Stmt happy_var_1))
	 =  HappyAbsSyn10
		 (Statement happy_var_1
	)
happyReduction_14 _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 21 21 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	Stmt happy_dollar_dollar -> cont 11;
	BinOr -> cont 12;
	BinAnd -> cont 13;
	Not -> cont 14;
	Implic -> cont 15;
	LeftParen -> cont 16;
	RightParen -> cont 17;
	EOLN -> cont 18;
	Comma -> cont 19;
	Turnstile -> cont 20;
	_ -> happyError' (tk:tks)
	}

happyError_ 21 tk tks = happyError' tks
happyError_ _ tk tks = happyError' (tk:tks)

happyThen :: () => Either String a -> (a -> Either String b) -> Either String b
happyThen = ((>>=))
happyReturn :: () => a -> Either String a
happyReturn = (return)
happyThen1 m k tks = ((>>=)) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> Either String a
happyReturn1 = \a tks -> (return) a
happyError' :: () => [(Token)] -> Either String a
happyError' = happyError

syntDeduct tks = happySomeParser where
  happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn5 z -> happyReturn z; _other -> notHappyAtAll })

syntExpr tks = happySomeParser where
  happySomeParser = happyThen (happyParse action_1 tks) (\x -> case x of {HappyAbsSyn10 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


happyError rest = Left $ "syntax error" ++ show rest

data DeductionProof =
    DeductionProof{
      statement :: Expr,
      assumption :: [Expr],
      proof :: [Expr]
    }
    deriving Eq

showExprList :: String -> [Expr] -> String
showExprList _ [] = ""
showExprList _ (x:[]) = show x
showExprList c (x:xs) = (show x) ++ c ++ showExprList c xs

             
instance Show DeductionProof where
    show x = (showExprList "," (assumption x)) ++ "|-" ++ (show (statement x)) ++ "\n" ++ (showExprList "\n" (proof x)) ++ "\n"

data BinOpType = Or | And | Impl
               deriving Eq

instance Show BinOpType where
  show x = case x of
    Or -> "|"
    And -> "&"
    Impl -> "->"

data UnOpType = LNot
              deriving Eq

instance Show UnOpType where
  show x = "!"

data Expr = Statement String
          | BinOp BinOpType Expr Expr
          | UnOp UnOpType Expr
  deriving Eq

instance Show Expr where
  show x = case x of
    Statement s -> s
    BinOp t a b -> "(" ++ (show a) ++ (show t) ++ (show b) ++ ")"
    UnOp t a -> "("++(show t) ++ (show a) ++ ")"
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "<command-line>" #-}





# 1 "/usr/include/stdc-predef.h" 1 3 4

# 17 "/usr/include/stdc-predef.h" 3 4










































# 5 "<command-line>" 2
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 

{-# LINE 30 "templates/GenericTemplate.hs" #-}








{-# LINE 51 "templates/GenericTemplate.hs" #-}

{-# LINE 61 "templates/GenericTemplate.hs" #-}

{-# LINE 70 "templates/GenericTemplate.hs" #-}

infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
	happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
	 (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

{-# LINE 148 "templates/GenericTemplate.hs" #-}

-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let (i) = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
	 sts1@(((st1@(HappyState (action))):(_))) ->
        	let r = fn stk in  -- it doesn't hurt to always seq here...
       		happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
        happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))
       where (sts1@(((st1@(HappyState (action))):(_)))) = happyDrop k ((st):(sts))
             drop_stk = happyDropStk k stk

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
       happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))
       where (sts1@(((st1@(HappyState (action))):(_)))) = happyDrop k ((st):(sts))
             drop_stk = happyDropStk k stk





             new_state = action


happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction

{-# LINE 246 "templates/GenericTemplate.hs" #-}
happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail (1) tk old_st _ stk@(x `HappyStk` _) =
     let (i) = (case x of { HappyErrorToken (i) -> i }) in
--	trace "failing" $ 
        happyError_ i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
						(saved_tok `HappyStk` _ `HappyStk` stk) =
--	trace ("discarding state, depth " ++ show (length stk))  $
	action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail  i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
	action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--	happySeq = happyDoSeq
-- otherwise it emits
-- 	happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.

{-# LINE 312 "templates/GenericTemplate.hs" #-}
{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
