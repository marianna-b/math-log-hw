{-# OPTIONS_GHC -w #-}
module Syntax where
import Lexer

-- parser produced by Happy Version 1.18.10

data HappyAbsSyn t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8
	| HappyAbsSyn9 t9
	| HappyAbsSyn10 t10
	| HappyAbsSyn11 t11
	| HappyAbsSyn12 t12
	| HappyAbsSyn13 t13
	| HappyAbsSyn14 t14
	| HappyAbsSyn15 t15
	| HappyAbsSyn16 t16

action_0 (17) = happyShift action_11
action_0 (18) = happyShift action_12
action_0 (21) = happyShift action_13
action_0 (23) = happyShift action_14
action_0 (27) = happyShift action_4
action_0 (29) = happyShift action_15
action_0 (33) = happyShift action_16
action_0 (34) = happyShift action_17
action_0 (6) = happyGoto action_19
action_0 (7) = happyGoto action_20
action_0 (8) = happyGoto action_21
action_0 (11) = happyGoto action_22
action_0 (12) = happyGoto action_8
action_0 (15) = happyGoto action_9
action_0 (16) = happyGoto action_10
action_0 _ = happyFail

action_1 (17) = happyShift action_11
action_1 (18) = happyShift action_12
action_1 (21) = happyShift action_13
action_1 (23) = happyShift action_14
action_1 (29) = happyShift action_15
action_1 (33) = happyShift action_16
action_1 (34) = happyShift action_17
action_1 (11) = happyGoto action_18
action_1 (12) = happyGoto action_8
action_1 (15) = happyGoto action_9
action_1 (16) = happyGoto action_10
action_1 _ = happyFail

action_2 (17) = happyShift action_11
action_2 (18) = happyShift action_12
action_2 (21) = happyShift action_13
action_2 (23) = happyShift action_14
action_2 (29) = happyShift action_15
action_2 (33) = happyShift action_16
action_2 (34) = happyShift action_17
action_2 (9) = happyGoto action_5
action_2 (10) = happyGoto action_6
action_2 (11) = happyGoto action_7
action_2 (12) = happyGoto action_8
action_2 (15) = happyGoto action_9
action_2 (16) = happyGoto action_10
action_2 _ = happyFail

action_3 (27) = happyShift action_4
action_3 _ = happyFail

action_4 (17) = happyShift action_11
action_4 (18) = happyShift action_12
action_4 (21) = happyShift action_13
action_4 (23) = happyShift action_14
action_4 (29) = happyShift action_15
action_4 (33) = happyShift action_16
action_4 (34) = happyShift action_17
action_4 (11) = happyGoto action_42
action_4 (12) = happyGoto action_8
action_4 (15) = happyGoto action_9
action_4 (16) = happyGoto action_10
action_4 _ = happyFail

action_5 (35) = happyAccept
action_5 _ = happyFail

action_6 (17) = happyShift action_11
action_6 (18) = happyShift action_12
action_6 (21) = happyShift action_13
action_6 (23) = happyShift action_14
action_6 (29) = happyShift action_15
action_6 (33) = happyShift action_16
action_6 (34) = happyShift action_17
action_6 (11) = happyGoto action_41
action_6 (12) = happyGoto action_8
action_6 (15) = happyGoto action_9
action_6 (16) = happyGoto action_10
action_6 _ = happyReduce_8

action_7 (19) = happyShift action_23
action_7 (20) = happyShift action_24
action_7 (22) = happyShift action_25
action_7 (25) = happyShift action_40
action_7 _ = happyFail

action_8 _ = happyReduce_14

action_9 (30) = happyShift action_37
action_9 (31) = happyShift action_38
action_9 (32) = happyShift action_39
action_9 _ = happyFail

action_10 (28) = happyShift action_36
action_10 _ = happyReduce_25

action_11 (23) = happyShift action_34
action_11 (13) = happyGoto action_35
action_11 _ = happyReduce_28

action_12 (23) = happyShift action_34
action_12 (13) = happyGoto action_33
action_12 _ = happyReduce_21

action_13 (17) = happyShift action_11
action_13 (18) = happyShift action_12
action_13 (21) = happyShift action_13
action_13 (23) = happyShift action_14
action_13 (29) = happyShift action_15
action_13 (33) = happyShift action_16
action_13 (34) = happyShift action_17
action_13 (12) = happyGoto action_32
action_13 (15) = happyGoto action_9
action_13 (16) = happyGoto action_10
action_13 _ = happyFail

action_14 (17) = happyShift action_11
action_14 (18) = happyShift action_12
action_14 (21) = happyShift action_13
action_14 (23) = happyShift action_14
action_14 (29) = happyShift action_15
action_14 (33) = happyShift action_16
action_14 (34) = happyShift action_17
action_14 (11) = happyGoto action_30
action_14 (12) = happyGoto action_8
action_14 (15) = happyGoto action_31
action_14 (16) = happyGoto action_10
action_14 _ = happyFail

action_15 _ = happyReduce_30

action_16 (17) = happyShift action_29
action_16 _ = happyFail

action_17 (17) = happyShift action_28
action_17 _ = happyFail

action_18 (19) = happyShift action_23
action_18 (20) = happyShift action_24
action_18 (22) = happyShift action_25
action_18 (35) = happyAccept
action_18 _ = happyFail

action_19 (35) = happyAccept
action_19 _ = happyFail

action_20 (27) = happyShift action_27
action_20 _ = happyFail

action_21 (26) = happyShift action_26
action_21 _ = happyReduce_5

action_22 (19) = happyShift action_23
action_22 (20) = happyShift action_24
action_22 (22) = happyShift action_25
action_22 _ = happyReduce_6

action_23 (17) = happyShift action_11
action_23 (18) = happyShift action_12
action_23 (21) = happyShift action_13
action_23 (23) = happyShift action_14
action_23 (29) = happyShift action_15
action_23 (33) = happyShift action_16
action_23 (34) = happyShift action_17
action_23 (11) = happyGoto action_58
action_23 (12) = happyGoto action_8
action_23 (15) = happyGoto action_9
action_23 (16) = happyGoto action_10
action_23 _ = happyFail

action_24 (17) = happyShift action_11
action_24 (18) = happyShift action_12
action_24 (21) = happyShift action_13
action_24 (23) = happyShift action_14
action_24 (29) = happyShift action_15
action_24 (33) = happyShift action_16
action_24 (34) = happyShift action_17
action_24 (11) = happyGoto action_57
action_24 (12) = happyGoto action_8
action_24 (15) = happyGoto action_9
action_24 (16) = happyGoto action_10
action_24 _ = happyFail

action_25 (17) = happyShift action_11
action_25 (18) = happyShift action_12
action_25 (21) = happyShift action_13
action_25 (23) = happyShift action_14
action_25 (29) = happyShift action_15
action_25 (33) = happyShift action_16
action_25 (34) = happyShift action_17
action_25 (11) = happyGoto action_56
action_25 (12) = happyGoto action_8
action_25 (15) = happyGoto action_9
action_25 (16) = happyGoto action_10
action_25 _ = happyFail

action_26 (17) = happyShift action_11
action_26 (18) = happyShift action_12
action_26 (21) = happyShift action_13
action_26 (23) = happyShift action_14
action_26 (29) = happyShift action_15
action_26 (33) = happyShift action_16
action_26 (34) = happyShift action_17
action_26 (11) = happyGoto action_55
action_26 (12) = happyGoto action_8
action_26 (15) = happyGoto action_9
action_26 (16) = happyGoto action_10
action_26 _ = happyFail

action_27 (17) = happyShift action_11
action_27 (18) = happyShift action_12
action_27 (21) = happyShift action_13
action_27 (23) = happyShift action_14
action_27 (29) = happyShift action_15
action_27 (33) = happyShift action_16
action_27 (34) = happyShift action_17
action_27 (11) = happyGoto action_54
action_27 (12) = happyGoto action_8
action_27 (15) = happyGoto action_9
action_27 (16) = happyGoto action_10
action_27 _ = happyFail

action_28 (17) = happyShift action_11
action_28 (18) = happyShift action_12
action_28 (21) = happyShift action_13
action_28 (23) = happyShift action_14
action_28 (29) = happyShift action_15
action_28 (33) = happyShift action_16
action_28 (34) = happyShift action_17
action_28 (12) = happyGoto action_53
action_28 (15) = happyGoto action_9
action_28 (16) = happyGoto action_10
action_28 _ = happyFail

action_29 (17) = happyShift action_11
action_29 (18) = happyShift action_12
action_29 (21) = happyShift action_13
action_29 (23) = happyShift action_14
action_29 (29) = happyShift action_15
action_29 (33) = happyShift action_16
action_29 (34) = happyShift action_17
action_29 (12) = happyGoto action_52
action_29 (15) = happyGoto action_9
action_29 (16) = happyGoto action_10
action_29 _ = happyFail

action_30 (19) = happyShift action_23
action_30 (20) = happyShift action_24
action_30 (22) = happyShift action_25
action_30 (24) = happyShift action_51
action_30 _ = happyFail

action_31 (24) = happyShift action_50
action_31 (30) = happyShift action_37
action_31 (31) = happyShift action_38
action_31 (32) = happyShift action_39
action_31 _ = happyFail

action_32 _ = happyReduce_16

action_33 _ = happyReduce_20

action_34 (17) = happyShift action_11
action_34 (23) = happyShift action_45
action_34 (29) = happyShift action_15
action_34 (14) = happyGoto action_48
action_34 (15) = happyGoto action_49
action_34 (16) = happyGoto action_10
action_34 _ = happyFail

action_35 _ = happyReduce_29

action_36 _ = happyReduce_32

action_37 (17) = happyShift action_11
action_37 (23) = happyShift action_45
action_37 (29) = happyShift action_15
action_37 (15) = happyGoto action_47
action_37 (16) = happyGoto action_10
action_37 _ = happyFail

action_38 (17) = happyShift action_11
action_38 (23) = happyShift action_45
action_38 (29) = happyShift action_15
action_38 (15) = happyGoto action_46
action_38 (16) = happyGoto action_10
action_38 _ = happyFail

action_39 (17) = happyShift action_11
action_39 (23) = happyShift action_45
action_39 (29) = happyShift action_15
action_39 (15) = happyGoto action_44
action_39 (16) = happyGoto action_10
action_39 _ = happyFail

action_40 _ = happyReduce_9

action_41 (19) = happyShift action_23
action_41 (20) = happyShift action_24
action_41 (22) = happyShift action_25
action_41 (25) = happyShift action_43
action_41 _ = happyFail

action_42 (19) = happyShift action_23
action_42 (20) = happyShift action_24
action_42 (22) = happyShift action_25
action_42 _ = happyReduce_3

action_43 _ = happyReduce_10

action_44 (30) = happyShift action_37
action_44 (31) = happyShift action_38
action_44 _ = happyReduce_19

action_45 (17) = happyShift action_11
action_45 (23) = happyShift action_45
action_45 (29) = happyShift action_15
action_45 (15) = happyGoto action_61
action_45 (16) = happyGoto action_10
action_45 _ = happyFail

action_46 (30) = happyShift action_37
action_46 _ = happyReduce_26

action_47 _ = happyReduce_27

action_48 (24) = happyShift action_59
action_48 (26) = happyShift action_60
action_48 _ = happyFail

action_49 (30) = happyShift action_37
action_49 (31) = happyShift action_38
action_49 _ = happyReduce_23

action_50 _ = happyReduce_31

action_51 _ = happyReduce_15

action_52 _ = happyReduce_17

action_53 _ = happyReduce_18

action_54 (19) = happyShift action_23
action_54 (20) = happyShift action_24
action_54 (22) = happyShift action_25
action_54 _ = happyReduce_4

action_55 (19) = happyShift action_23
action_55 (20) = happyShift action_24
action_55 (22) = happyShift action_25
action_55 _ = happyReduce_7

action_56 (19) = happyShift action_23
action_56 (20) = happyShift action_24
action_56 (22) = happyShift action_25
action_56 _ = happyReduce_11

action_57 _ = happyReduce_13

action_58 (20) = happyShift action_24
action_58 _ = happyReduce_12

action_59 _ = happyReduce_22

action_60 (17) = happyShift action_11
action_60 (23) = happyShift action_45
action_60 (29) = happyShift action_15
action_60 (15) = happyGoto action_62
action_60 (16) = happyGoto action_10
action_60 _ = happyFail

action_61 (24) = happyShift action_50
action_61 (30) = happyShift action_37
action_61 (31) = happyShift action_38
action_61 _ = happyFail

action_62 (30) = happyShift action_37
action_62 (31) = happyShift action_38
action_62 _ = happyReduce_24

happyReduce_3 = happySpecReduce_2  6 happyReduction_3
happyReduction_3 (HappyAbsSyn11  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (DeductionProof happy_var_2 [] []
	)
happyReduction_3 _ _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_3  6 happyReduction_4
happyReduction_4 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn6
		 (DeductionProof happy_var_3 happy_var_1 []
	)
happyReduction_4 _ _ _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_1  7 happyReduction_5
happyReduction_5 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn7
		 (reverse happy_var_1
	)
happyReduction_5 _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_1  8 happyReduction_6
happyReduction_6 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn8
		 ([happy_var_1]
	)
happyReduction_6 _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_3  8 happyReduction_7
happyReduction_7 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn8
		 (happy_var_3 : happy_var_1
	)
happyReduction_7 _ _ _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_1  9 happyReduction_8
happyReduction_8 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn9
		 (reverse happy_var_1
	)
happyReduction_8 _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_2  10 happyReduction_9
happyReduction_9 _
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn10
		 ([happy_var_1]
	)
happyReduction_9 _ _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_3  10 happyReduction_10
happyReduction_10 _
	(HappyAbsSyn11  happy_var_2)
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (happy_var_2 : happy_var_1
	)
happyReduction_10 _ _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_3  11 happyReduction_11
happyReduction_11 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (BinOp Impl happy_var_1 happy_var_3
	)
happyReduction_11 _ _ _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_3  11 happyReduction_12
happyReduction_12 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (BinOp Or happy_var_1 happy_var_3
	)
happyReduction_12 _ _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_3  11 happyReduction_13
happyReduction_13 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (BinOp And happy_var_1 happy_var_3
	)
happyReduction_13 _ _ _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_1  11 happyReduction_14
happyReduction_14 (HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn11
		 (happy_var_1
	)
happyReduction_14 _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_3  12 happyReduction_15
happyReduction_15 _
	(HappyAbsSyn11  happy_var_2)
	_
	 =  HappyAbsSyn12
		 (happy_var_2
	)
happyReduction_15 _ _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_2  12 happyReduction_16
happyReduction_16 (HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn12
		 (UnOp UnNot happy_var_2
	)
happyReduction_16 _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_3  12 happyReduction_17
happyReduction_17 (HappyAbsSyn12  happy_var_3)
	(HappyTerminal (TVariable happy_var_2))
	_
	 =  HappyAbsSyn12
		 (Quantifier Forall happy_var_2 happy_var_3
	)
happyReduction_17 _ _ _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_3  12 happyReduction_18
happyReduction_18 (HappyAbsSyn12  happy_var_3)
	(HappyTerminal (TVariable happy_var_2))
	_
	 =  HappyAbsSyn12
		 (Quantifier Exists happy_var_2 happy_var_3
	)
happyReduction_18 _ _ _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_3  12 happyReduction_19
happyReduction_19 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn12
		 (Equals happy_var_1 happy_var_3
	)
happyReduction_19 _ _ _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_2  12 happyReduction_20
happyReduction_20 (HappyAbsSyn13  happy_var_2)
	(HappyTerminal (TPredicatSymb happy_var_1))
	 =  HappyAbsSyn12
		 (PredicateSymb happy_var_1 happy_var_2
	)
happyReduction_20 _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_1  12 happyReduction_21
happyReduction_21 (HappyTerminal (TPredicatSymb happy_var_1))
	 =  HappyAbsSyn12
		 (PredicateSymb happy_var_1 []
	)
happyReduction_21 _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_3  13 happyReduction_22
happyReduction_22 _
	(HappyAbsSyn14  happy_var_2)
	_
	 =  HappyAbsSyn13
		 (reverse happy_var_2
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_1  14 happyReduction_23
happyReduction_23 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn14
		 ([happy_var_1]
	)
happyReduction_23 _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_3  14 happyReduction_24
happyReduction_24 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (happy_var_3 : happy_var_1
	)
happyReduction_24 _ _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_1  15 happyReduction_25
happyReduction_25 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn15
		 (happy_var_1
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_3  15 happyReduction_26
happyReduction_26 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn15
		 (BinFunction Plus happy_var_1 happy_var_3
	)
happyReduction_26 _ _ _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_3  15 happyReduction_27
happyReduction_27 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn15
		 (BinFunction Mul happy_var_1 happy_var_3
	)
happyReduction_27 _ _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_1  16 happyReduction_28
happyReduction_28 (HappyTerminal (TVariable happy_var_1))
	 =  HappyAbsSyn16
		 (Variable happy_var_1
	)
happyReduction_28 _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_2  16 happyReduction_29
happyReduction_29 (HappyAbsSyn13  happy_var_2)
	(HappyTerminal (TVariable happy_var_1))
	 =  HappyAbsSyn16
		 (MultiFunction happy_var_1 happy_var_2
	)
happyReduction_29 _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_1  16 happyReduction_30
happyReduction_30 _
	 =  HappyAbsSyn16
		 (ZeroTerm
	)

happyReduce_31 = happySpecReduce_3  16 happyReduction_31
happyReduction_31 _
	(HappyAbsSyn15  happy_var_2)
	_
	 =  HappyAbsSyn16
		 (happy_var_2
	)
happyReduction_31 _ _ _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_2  16 happyReduction_32
happyReduction_32 _
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 (Apostrophe happy_var_1
	)
happyReduction_32 _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 35 35 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TVariable happy_dollar_dollar -> cont 17;
	TPredicatSymb happy_dollar_dollar -> cont 18;
	TBinOr -> cont 19;
	TBinAnd -> cont 20;
	TNot -> cont 21;
	TImplic -> cont 22;
	TLeftParen -> cont 23;
	TRightParen -> cont 24;
	TEOLN -> cont 25;
	TComma -> cont 26;
	TTurnstile -> cont 27;
	TApostrophe -> cont 28;
	TZero -> cont 29;
	TMultiply -> cont 30;
	TPlus -> cont 31;
	TEquality -> cont 32;
	TQuantifierAll -> cont 33;
	TQuantifierExists -> cont 34;
	_ -> happyError' (tk:tks)
	}

happyError_ 35 tk tks = happyError' tks
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

syntAssump tks = happySomeParser where
  happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn6 z -> happyReturn z; _other -> notHappyAtAll })

syntExpr tks = happySomeParser where
  happySomeParser = happyThen (happyParse action_1 tks) (\x -> case x of {HappyAbsSyn11 z -> happyReturn z; _other -> notHappyAtAll })

syntProof tks = happySomeParser where
  happySomeParser = happyThen (happyParse action_2 tks) (\x -> case x of {HappyAbsSyn9 z -> happyReturn z; _other -> notHappyAtAll })

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
  deriving (Eq, Ord)

instance Show BinFunType where
  show x = case x of
    Plus -> "+"
    Mul -> "*"

data Term = BinFunction BinFunType Term Term
          | MultiFunction String [Term]
          | ZeroTerm
          | Apostrophe Term
          | Variable String
  deriving (Eq, Ord)

instance Show Term where
  show x = case x of
    ZeroTerm -> "0"
    Variable v -> v
    MultiFunction x list -> "(" ++ x ++ "(" ++ (showTermList "," list) ++ "))"
    BinFunction t a b -> "(" ++ (show a) ++ (show t) ++ (show b) ++ ")"
    Apostrophe a -> "("++(show a) ++ "')"

data QuType = Forall | Exists
  deriving (Eq, Ord)

instance Show QuType where
  show x = case x of
    Forall -> "@"
    Exists -> "?"

showTermList :: String -> [Term] -> String
showTermList _ [] = ""
showTermList _ (x:[]) = show x
showTermList c (x:xs) = (show x) ++ c ++ showTermList c xs

data Expr = Equals Term Term
          | PredicateSymb String [Term]
          | Quantifier QuType String Expr 
          | BinOp BinOpType Expr Expr
          | UnOp UnOpType Expr
  deriving (Eq, Ord)

instance Show Expr where
  show x = case x of
    Equals a b -> "(" ++ (show a) ++ "=" ++  (show b) ++ ")"
    Quantifier t x e -> "(" ++ (show t) ++ x ++ "(" ++ (show e) ++ "))"
    PredicateSymb x [] -> x
    PredicateSymb x list -> "(" ++ x ++ "(" ++ (showTermList "," list) ++ "))"
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
