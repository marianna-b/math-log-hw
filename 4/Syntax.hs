{-# OPTIONS_GHC -w #-}
module Syntax where
import Lexer

-- parser produced by Happy Version 1.18.10

data HappyAbsSyn t5 t6 t7 t8 t9 t10 t11 t12 t13 t14
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8
	| HappyAbsSyn9 t9
	| HappyAbsSyn10 t10
	| HappyAbsSyn11 t11
	| HappyAbsSyn12 t12
	| HappyAbsSyn13 t13
	| HappyAbsSyn14 t14

action_0 (15) = happyShift action_7
action_0 (16) = happyShift action_8
action_0 (19) = happyShift action_9
action_0 (21) = happyShift action_10
action_0 (25) = happyShift action_3
action_0 (27) = happyShift action_11
action_0 (31) = happyShift action_12
action_0 (32) = happyShift action_13
action_0 (5) = happyGoto action_14
action_0 (6) = happyGoto action_15
action_0 (7) = happyGoto action_16
action_0 (10) = happyGoto action_17
action_0 (13) = happyGoto action_5
action_0 (14) = happyGoto action_6
action_0 _ = happyFail

action_1 (15) = happyShift action_7
action_1 (16) = happyShift action_8
action_1 (19) = happyShift action_9
action_1 (21) = happyShift action_10
action_1 (27) = happyShift action_11
action_1 (31) = happyShift action_12
action_1 (32) = happyShift action_13
action_1 (10) = happyGoto action_4
action_1 (13) = happyGoto action_5
action_1 (14) = happyGoto action_6
action_1 _ = happyFail

action_2 (25) = happyShift action_3
action_2 _ = happyFail

action_3 (15) = happyShift action_7
action_3 (16) = happyShift action_8
action_3 (19) = happyShift action_9
action_3 (21) = happyShift action_10
action_3 (27) = happyShift action_11
action_3 (31) = happyShift action_12
action_3 (32) = happyShift action_13
action_3 (10) = happyGoto action_35
action_3 (13) = happyGoto action_5
action_3 (14) = happyGoto action_6
action_3 _ = happyFail

action_4 (17) = happyShift action_18
action_4 (18) = happyShift action_19
action_4 (20) = happyShift action_20
action_4 (33) = happyAccept
action_4 _ = happyFail

action_5 (28) = happyShift action_32
action_5 (29) = happyShift action_33
action_5 (30) = happyShift action_34
action_5 _ = happyFail

action_6 (26) = happyShift action_31
action_6 _ = happyReduce_23

action_7 (21) = happyShift action_29
action_7 (11) = happyGoto action_30
action_7 _ = happyReduce_26

action_8 (21) = happyShift action_29
action_8 (11) = happyGoto action_28
action_8 _ = happyReduce_19

action_9 (15) = happyShift action_7
action_9 (16) = happyShift action_8
action_9 (19) = happyShift action_9
action_9 (21) = happyShift action_10
action_9 (27) = happyShift action_11
action_9 (31) = happyShift action_12
action_9 (32) = happyShift action_13
action_9 (10) = happyGoto action_27
action_9 (13) = happyGoto action_5
action_9 (14) = happyGoto action_6
action_9 _ = happyFail

action_10 (15) = happyShift action_7
action_10 (16) = happyShift action_8
action_10 (19) = happyShift action_9
action_10 (21) = happyShift action_10
action_10 (27) = happyShift action_11
action_10 (31) = happyShift action_12
action_10 (32) = happyShift action_13
action_10 (10) = happyGoto action_25
action_10 (13) = happyGoto action_26
action_10 (14) = happyGoto action_6
action_10 _ = happyFail

action_11 _ = happyReduce_28

action_12 (15) = happyShift action_24
action_12 _ = happyFail

action_13 (15) = happyShift action_23
action_13 _ = happyFail

action_14 (33) = happyAccept
action_14 _ = happyFail

action_15 (25) = happyShift action_22
action_15 _ = happyFail

action_16 (24) = happyShift action_21
action_16 _ = happyReduce_4

action_17 (17) = happyShift action_18
action_17 (18) = happyShift action_19
action_17 (20) = happyShift action_20
action_17 _ = happyReduce_5

action_18 (15) = happyShift action_7
action_18 (16) = happyShift action_8
action_18 (19) = happyShift action_9
action_18 (21) = happyShift action_10
action_18 (27) = happyShift action_11
action_18 (31) = happyShift action_12
action_18 (32) = happyShift action_13
action_18 (10) = happyGoto action_51
action_18 (13) = happyGoto action_5
action_18 (14) = happyGoto action_6
action_18 _ = happyFail

action_19 (15) = happyShift action_7
action_19 (16) = happyShift action_8
action_19 (19) = happyShift action_9
action_19 (21) = happyShift action_10
action_19 (27) = happyShift action_11
action_19 (31) = happyShift action_12
action_19 (32) = happyShift action_13
action_19 (10) = happyGoto action_50
action_19 (13) = happyGoto action_5
action_19 (14) = happyGoto action_6
action_19 _ = happyFail

action_20 (15) = happyShift action_7
action_20 (16) = happyShift action_8
action_20 (19) = happyShift action_9
action_20 (21) = happyShift action_10
action_20 (27) = happyShift action_11
action_20 (31) = happyShift action_12
action_20 (32) = happyShift action_13
action_20 (10) = happyGoto action_49
action_20 (13) = happyGoto action_5
action_20 (14) = happyGoto action_6
action_20 _ = happyFail

action_21 (15) = happyShift action_7
action_21 (16) = happyShift action_8
action_21 (19) = happyShift action_9
action_21 (21) = happyShift action_10
action_21 (27) = happyShift action_11
action_21 (31) = happyShift action_12
action_21 (32) = happyShift action_13
action_21 (10) = happyGoto action_48
action_21 (13) = happyGoto action_5
action_21 (14) = happyGoto action_6
action_21 _ = happyFail

action_22 (15) = happyShift action_7
action_22 (16) = happyShift action_8
action_22 (19) = happyShift action_9
action_22 (21) = happyShift action_10
action_22 (27) = happyShift action_11
action_22 (31) = happyShift action_12
action_22 (32) = happyShift action_13
action_22 (10) = happyGoto action_47
action_22 (13) = happyGoto action_5
action_22 (14) = happyGoto action_6
action_22 _ = happyFail

action_23 (15) = happyShift action_7
action_23 (16) = happyShift action_8
action_23 (19) = happyShift action_9
action_23 (21) = happyShift action_10
action_23 (27) = happyShift action_11
action_23 (31) = happyShift action_12
action_23 (32) = happyShift action_13
action_23 (10) = happyGoto action_46
action_23 (13) = happyGoto action_5
action_23 (14) = happyGoto action_6
action_23 _ = happyFail

action_24 (15) = happyShift action_7
action_24 (16) = happyShift action_8
action_24 (19) = happyShift action_9
action_24 (21) = happyShift action_10
action_24 (27) = happyShift action_11
action_24 (31) = happyShift action_12
action_24 (32) = happyShift action_13
action_24 (10) = happyGoto action_45
action_24 (13) = happyGoto action_5
action_24 (14) = happyGoto action_6
action_24 _ = happyFail

action_25 (17) = happyShift action_18
action_25 (18) = happyShift action_19
action_25 (20) = happyShift action_20
action_25 (22) = happyShift action_44
action_25 _ = happyFail

action_26 (22) = happyShift action_43
action_26 (28) = happyShift action_32
action_26 (29) = happyShift action_33
action_26 (30) = happyShift action_34
action_26 _ = happyFail

action_27 _ = happyReduce_14

action_28 _ = happyReduce_18

action_29 (15) = happyShift action_7
action_29 (21) = happyShift action_38
action_29 (27) = happyShift action_11
action_29 (12) = happyGoto action_41
action_29 (13) = happyGoto action_42
action_29 (14) = happyGoto action_6
action_29 _ = happyFail

action_30 _ = happyReduce_27

action_31 _ = happyReduce_30

action_32 (15) = happyShift action_7
action_32 (21) = happyShift action_38
action_32 (27) = happyShift action_11
action_32 (13) = happyGoto action_40
action_32 (14) = happyGoto action_6
action_32 _ = happyFail

action_33 (15) = happyShift action_7
action_33 (21) = happyShift action_38
action_33 (27) = happyShift action_11
action_33 (13) = happyGoto action_39
action_33 (14) = happyGoto action_6
action_33 _ = happyFail

action_34 (15) = happyShift action_7
action_34 (21) = happyShift action_38
action_34 (27) = happyShift action_11
action_34 (13) = happyGoto action_37
action_34 (14) = happyGoto action_6
action_34 _ = happyFail

action_35 (17) = happyShift action_18
action_35 (18) = happyShift action_19
action_35 (20) = happyShift action_20
action_35 (23) = happyShift action_36
action_35 _ = happyFail

action_36 (15) = happyShift action_7
action_36 (16) = happyShift action_8
action_36 (19) = happyShift action_9
action_36 (21) = happyShift action_10
action_36 (27) = happyShift action_11
action_36 (31) = happyShift action_12
action_36 (32) = happyShift action_13
action_36 (8) = happyGoto action_56
action_36 (9) = happyGoto action_57
action_36 (10) = happyGoto action_58
action_36 (13) = happyGoto action_5
action_36 (14) = happyGoto action_6
action_36 _ = happyFail

action_37 (28) = happyShift action_32
action_37 (29) = happyShift action_33
action_37 _ = happyReduce_17

action_38 (15) = happyShift action_7
action_38 (21) = happyShift action_38
action_38 (27) = happyShift action_11
action_38 (13) = happyGoto action_55
action_38 (14) = happyGoto action_6
action_38 _ = happyFail

action_39 (28) = happyShift action_32
action_39 _ = happyReduce_24

action_40 _ = happyReduce_25

action_41 (22) = happyShift action_53
action_41 (24) = happyShift action_54
action_41 _ = happyFail

action_42 (28) = happyShift action_32
action_42 (29) = happyShift action_33
action_42 _ = happyReduce_21

action_43 _ = happyReduce_29

action_44 _ = happyReduce_10

action_45 (17) = happyShift action_18
action_45 (18) = happyShift action_19
action_45 (20) = happyShift action_20
action_45 _ = happyReduce_15

action_46 (17) = happyShift action_18
action_46 (18) = happyShift action_19
action_46 (20) = happyShift action_20
action_46 _ = happyReduce_16

action_47 (17) = happyShift action_18
action_47 (18) = happyShift action_19
action_47 (20) = happyShift action_20
action_47 (23) = happyShift action_52
action_47 _ = happyFail

action_48 (17) = happyShift action_18
action_48 (18) = happyShift action_19
action_48 (20) = happyShift action_20
action_48 _ = happyReduce_6

action_49 (17) = happyShift action_18
action_49 (18) = happyShift action_19
action_49 (20) = happyShift action_20
action_49 _ = happyReduce_11

action_50 _ = happyReduce_13

action_51 (18) = happyShift action_19
action_51 _ = happyReduce_12

action_52 (15) = happyShift action_7
action_52 (16) = happyShift action_8
action_52 (19) = happyShift action_9
action_52 (21) = happyShift action_10
action_52 (27) = happyShift action_11
action_52 (31) = happyShift action_12
action_52 (32) = happyShift action_13
action_52 (8) = happyGoto action_62
action_52 (9) = happyGoto action_57
action_52 (10) = happyGoto action_58
action_52 (13) = happyGoto action_5
action_52 (14) = happyGoto action_6
action_52 _ = happyFail

action_53 _ = happyReduce_20

action_54 (15) = happyShift action_7
action_54 (21) = happyShift action_38
action_54 (27) = happyShift action_11
action_54 (13) = happyGoto action_61
action_54 (14) = happyGoto action_6
action_54 _ = happyFail

action_55 (22) = happyShift action_43
action_55 (28) = happyShift action_32
action_55 (29) = happyShift action_33
action_55 _ = happyFail

action_56 _ = happyReduce_2

action_57 (15) = happyShift action_7
action_57 (16) = happyShift action_8
action_57 (19) = happyShift action_9
action_57 (21) = happyShift action_10
action_57 (27) = happyShift action_11
action_57 (31) = happyShift action_12
action_57 (32) = happyShift action_13
action_57 (10) = happyGoto action_60
action_57 (13) = happyGoto action_5
action_57 (14) = happyGoto action_6
action_57 _ = happyReduce_7

action_58 (17) = happyShift action_18
action_58 (18) = happyShift action_19
action_58 (20) = happyShift action_20
action_58 (23) = happyShift action_59
action_58 _ = happyFail

action_59 _ = happyReduce_8

action_60 (17) = happyShift action_18
action_60 (18) = happyShift action_19
action_60 (20) = happyShift action_20
action_60 (23) = happyShift action_63
action_60 _ = happyFail

action_61 (28) = happyShift action_32
action_61 (29) = happyShift action_33
action_61 _ = happyReduce_22

action_62 _ = happyReduce_3

action_63 _ = happyReduce_9

happyReduce_2 = happyReduce 4 5 happyReduction_2
happyReduction_2 ((HappyAbsSyn8  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn10  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (DeductionProof happy_var_2 [] happy_var_4
	) `HappyStk` happyRest

happyReduce_3 = happyReduce 5 5 happyReduction_3
happyReduction_3 ((HappyAbsSyn8  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn10  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (DeductionProof happy_var_3 happy_var_1 happy_var_5
	) `HappyStk` happyRest

happyReduce_4 = happySpecReduce_1  6 happyReduction_4
happyReduction_4 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn6
		 (reverse happy_var_1
	)
happyReduction_4 _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_1  7 happyReduction_5
happyReduction_5 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn7
		 ([happy_var_1]
	)
happyReduction_5 _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_3  7 happyReduction_6
happyReduction_6 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_3 : happy_var_1
	)
happyReduction_6 _ _ _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_1  8 happyReduction_7
happyReduction_7 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn8
		 (reverse happy_var_1
	)
happyReduction_7 _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_2  9 happyReduction_8
happyReduction_8 _
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn9
		 ([happy_var_1]
	)
happyReduction_8 _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_3  9 happyReduction_9
happyReduction_9 _
	(HappyAbsSyn10  happy_var_2)
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (happy_var_2 : happy_var_1
	)
happyReduction_9 _ _ _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_3  10 happyReduction_10
happyReduction_10 _
	(HappyAbsSyn10  happy_var_2)
	_
	 =  HappyAbsSyn10
		 (happy_var_2
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

happyReduce_12 = happySpecReduce_3  10 happyReduction_12
happyReduction_12 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (BinOp Or happy_var_1 happy_var_3
	)
happyReduction_12 _ _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_3  10 happyReduction_13
happyReduction_13 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (BinOp And happy_var_1 happy_var_3
	)
happyReduction_13 _ _ _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_2  10 happyReduction_14
happyReduction_14 (HappyAbsSyn10  happy_var_2)
	_
	 =  HappyAbsSyn10
		 (UnOp UnNot happy_var_2
	)
happyReduction_14 _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_3  10 happyReduction_15
happyReduction_15 (HappyAbsSyn10  happy_var_3)
	(HappyTerminal (TVariable happy_var_2))
	_
	 =  HappyAbsSyn10
		 (Quantifier Forall happy_var_2 happy_var_3
	)
happyReduction_15 _ _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_3  10 happyReduction_16
happyReduction_16 (HappyAbsSyn10  happy_var_3)
	(HappyTerminal (TVariable happy_var_2))
	_
	 =  HappyAbsSyn10
		 (Quantifier Exists happy_var_2 happy_var_3
	)
happyReduction_16 _ _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_3  10 happyReduction_17
happyReduction_17 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn10
		 (Equals happy_var_1 happy_var_3
	)
happyReduction_17 _ _ _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_2  10 happyReduction_18
happyReduction_18 (HappyAbsSyn11  happy_var_2)
	(HappyTerminal (TPredicatSymb happy_var_1))
	 =  HappyAbsSyn10
		 (PredicateSymb happy_var_1 happy_var_2
	)
happyReduction_18 _ _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_1  10 happyReduction_19
happyReduction_19 (HappyTerminal (TPredicatSymb happy_var_1))
	 =  HappyAbsSyn10
		 (PredicateSymb happy_var_1 []
	)
happyReduction_19 _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_3  11 happyReduction_20
happyReduction_20 _
	(HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn11
		 (reverse happy_var_2
	)
happyReduction_20 _ _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_1  12 happyReduction_21
happyReduction_21 (HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn12
		 ([happy_var_1]
	)
happyReduction_21 _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_3  12 happyReduction_22
happyReduction_22 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn12
		 (happy_var_3 : happy_var_1
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_1  13 happyReduction_23
happyReduction_23 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn13
		 (happy_var_1
	)
happyReduction_23 _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_3  13 happyReduction_24
happyReduction_24 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (BinFunction Plus happy_var_1 happy_var_3
	)
happyReduction_24 _ _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_3  13 happyReduction_25
happyReduction_25 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (BinFunction Mul happy_var_1 happy_var_3
	)
happyReduction_25 _ _ _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_1  14 happyReduction_26
happyReduction_26 (HappyTerminal (TVariable happy_var_1))
	 =  HappyAbsSyn14
		 (Variable happy_var_1
	)
happyReduction_26 _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_2  14 happyReduction_27
happyReduction_27 (HappyAbsSyn11  happy_var_2)
	(HappyTerminal (TVariable happy_var_1))
	 =  HappyAbsSyn14
		 (MultiFunction happy_var_1 happy_var_2
	)
happyReduction_27 _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_1  14 happyReduction_28
happyReduction_28 _
	 =  HappyAbsSyn14
		 (ZeroTerm
	)

happyReduce_29 = happySpecReduce_3  14 happyReduction_29
happyReduction_29 _
	(HappyAbsSyn13  happy_var_2)
	_
	 =  HappyAbsSyn14
		 (happy_var_2
	)
happyReduction_29 _ _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_2  14 happyReduction_30
happyReduction_30 _
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (Apostrophe happy_var_1
	)
happyReduction_30 _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 33 33 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TVariable happy_dollar_dollar -> cont 15;
	TPredicatSymb happy_dollar_dollar -> cont 16;
	TBinOr -> cont 17;
	TBinAnd -> cont 18;
	TNot -> cont 19;
	TImplic -> cont 20;
	TLeftParen -> cont 21;
	TRightParen -> cont 22;
	TEOLN -> cont 23;
	TComma -> cont 24;
	TTurnstile -> cont 25;
	TApostrophe -> cont 26;
	TZero -> cont 27;
	TMultiply -> cont 28;
	TPlus -> cont 29;
	TEquality -> cont 30;
	TQuantifierAll -> cont 31;
	TQuantifierExists -> cont 32;
	_ -> happyError' (tk:tks)
	}

happyError_ 33 tk tks = happyError' tks
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
    deriving (Ord, Eq)

showExprList :: String -> [Expr] -> String
showExprList _ [] = ""
showExprList _ (x:[]) = show x
showExprList c (x:xs) = (show x) ++ c ++ showExprList c xs

             
instance Show DeductionProof where
    show x = (showExprList "," (assumption x)) ++ "|-" ++ (show (statement x)) ++ "\n" ++ (showExprList "\n" (proof x)) ++ "\n"

data BinOpType = Or | And | Impl
               deriving (Ord, Eq)

instance Show BinOpType where
  show x = case x of
    Or -> "|"
    And -> "&"
    Impl -> "->"

data UnOpType = UnNot
              deriving (Ord, Eq)

instance Show UnOpType where
  show x = "!"
data BinFunType = Plus | Mul
  deriving (Eq, Ord, Show)
data Term = BinFunction BinFunType Term Term
          | MultiFunction String [Term]
          | ZeroTerm
          | Apostrophe Term
          | Variable String
  deriving (Eq, Ord, Show)
data QuType = Forall | Exists
  deriving (Eq, Ord, Show)

data Expr = Equals Term Term
          | PredicateSymb String [Term]
          | Quantifier QuType String Expr 
          | BinOp BinOpType Expr Expr
          | UnOp UnOpType Expr
  deriving (Eq, Ord, Show)
{-
instance Show Expr where
  show x = case x of
    Statement s -> s
    BinOp t a b -> "(" ++ (show a) ++ (show t) ++ (show b) ++ ")"
    UnOp t a -> "("++(show t) ++ (show a) ++ ")" -}
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
