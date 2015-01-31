module ProofsQuantifiers where

import qualified Data.Map.Strict as M
import Lexer
import Syntax
import FAApplyDeductionLib
import FAModusPonens

loadProof :: String -> M.Map String Proof -> IO (M.Map String Proof)
loadProof s proofMap = do
  inp <- readFile $ s
  case tok inp >>= syntProof of
    Left err -> error err
    Right prf -> return $ M.insert s prf proofMap 

getProofMap :: IO ProofMap
getProofMap =
    loadProof "quantifiers/first/exists/and1" M.empty >>=
    loadProof "quantifiers/first/exists/and2" >>=
    loadProof "quantifiers/first/exists/impl1" >>=
    loadProof "quantifiers/first/exists/impl2" >>=
    loadProof "quantifiers/first/exists/or1" >>=
    loadProof "quantifiers/first/exists/or2" >>=
    loadProof "quantifiers/first/forall/and1" >>=
    loadProof "quantifiers/first/forall/and2" >>=
    loadProof "quantifiers/first/forall/impl1" >>=
    loadProof "quantifiers/first/forall/impl2" >>=
    loadProof "quantifiers/first/forall/or1" >>=
    loadProof "quantifiers/first/forall/or2" >>=
    loadProof "quantifiers/second/exists/and1" >>=
    loadProof "quantifiers/second/exists/and2" >>=
    loadProof "quantifiers/second/exists/impl1" >>=
    loadProof "quantifiers/second/exists/impl2" >>=
    loadProof "quantifiers/second/exists/or1" >>=
    loadProof "quantifiers/second/exists/or2" >>=
    loadProof "quantifiers/second/forall/and1" >>=
    loadProof "quantifiers/second/forall/and2" >>=
    loadProof "quantifiers/second/forall/impl1" >>=
    loadProof "quantifiers/second/forall/impl2" >>=
    loadProof "quantifiers/second/forall/or1" >>=
    loadProof "quantifiers/second/forall/or2" >>=
    loadProof "quantifiers/single/exists/and1" >>=
    loadProof "quantifiers/single/exists/and2" >>=
    loadProof "quantifiers/single/exists/impl1" >>=
    loadProof "quantifiers/single/exists/impl2" >>=
    loadProof "quantifiers/single/exists/or1" >>=
    loadProof "quantifiers/single/exists/or2" >>=
    loadProof "quantifiers/single/forall/and1" >>=
    loadProof "quantifiers/single/forall/and2" >>=
    loadProof "quantifiers/single/forall/impl1" >>=
    loadProof "quantifiers/single/forall/impl2" >>=
    loadProof "quantifiers/single/forall/or1" >>=
    loadProof "quantifiers/single/forall/or2" >>=
    loadProof "replace/and" >>=
    loadProof "replace/or" >>=
    loadProof "replace/impl" >>=
    loadProof "replace/not" >>=
    loadProof "replace/forall" >>=
    loadProof "replace/exists"
