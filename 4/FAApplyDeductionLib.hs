module FAApplyDeductionLib where

import FAProofCheckLib 
import Syntax
import qualified Data.Map.Strict as M

type ProofMap = M.Map String Proof

errorDeduct :: DeductionProof -> Context -> Maybe NotProoved
errorDeduct = undefined

applyDeduct :: DeductionProof -> Context -> Either NotProoved DeductionProof
applyDeduct = undefined
