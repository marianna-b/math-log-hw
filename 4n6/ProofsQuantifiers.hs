module ProofsQuantifiers where

import qualified Data.Map.Strict as M
import Lexer
import Syntax
import FAApplyDeductionLib
import FAModusPonens
import Debug.Trace


parseProof :: [String] -> [Expr]
parseProof [] = []
parseProof (x:xs)
 | x == "" = (parseProof xs)
 | otherwise = case tok x >>= syntExpr of
                 Left err -> error err
                 Right r -> r:(parseProof xs)

loadProof :: String -> M.Map String Proof -> IO (M.Map String Proof)
loadProof s proofMap = do
  inp <- readFile $ s
  return $ M.insert s (parseProof (lines inp)) proofMap 

getProofMap :: IO ProofMap
getProofMap =
    loadProof (trace "1" "quantifiers/first/exists/and1") M.empty >>=
    loadProof (trace "2" "quantifiers/first/exists/and2") >>=
    loadProof (trace "3" "quantifiers/first/exists/impl1") >>=
    loadProof (trace "4" "quantifiers/first/exists/impl2") >>=
    loadProof (trace "5" "quantifiers/first/exists/or1") >>=
    loadProof (trace "6" "quantifiers/first/exists/or2") >>=
    loadProof (trace "7" "quantifiers/first/forall/and1") >>=
    loadProof (trace "9" "quantifiers/first/forall/and2") >>=
    loadProof (trace "10" "quantifiers/first/forall/impl1") >>=
    loadProof (trace "11" "quantifiers/first/forall/impl2") >>=
    loadProof (trace "12" "quantifiers/first/forall/or1") >>=
    loadProof (trace "13" "quantifiers/first/forall/or2") >>=
    loadProof (trace "14" "quantifiers/second/exists/and1") >>=
    loadProof (trace "15" "quantifiers/second/exists/and2") >>=
    loadProof (trace "16" "quantifiers/second/exists/impl1") >>=
    loadProof (trace "17" "quantifiers/second/exists/impl2") >>=
    loadProof (trace "18" "quantifiers/second/exists/or1") >>=
    loadProof (trace "19" "quantifiers/second/exists/or2") >>=
    loadProof (trace "20" "quantifiers/second/forall/and1") >>=
    loadProof (trace "21" "quantifiers/second/forall/and2") >>=
    loadProof (trace "22" "quantifiers/second/forall/impl1") >>=
    loadProof (trace "23" "quantifiers/second/forall/impl2") >>=
    loadProof (trace "24" "quantifiers/second/forall/or1") >>=
    loadProof (trace "25" "quantifiers/second/forall/or2") >>=
    loadProof (trace "26" "quantifiers/single/exists/not1") >>=
    loadProof (trace "27" "quantifiers/single/exists/not2") >>=
    loadProof (trace "28" "quantifiers/single/exists/rename") >>=
    loadProof (trace "29" "quantifiers/single/forall/rename") >>=
    loadProof (trace "30" "quantifiers/single/forall/not1") >>=
    loadProof (trace "31" "quantifiers/single/forall/not2") >>=
    loadProof (trace "32" "replace/and") >>=
    loadProof (trace "33" "replace/or") >>=
    loadProof (trace "34" "replace/impl") >>=
    loadProof (trace "35" "replace/not") >>=
    loadProof (trace "36" "replace/forall") >>=
    loadProof (trace "37" "replace/exists")
