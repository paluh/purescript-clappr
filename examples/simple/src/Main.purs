module Examples.Simple.Main where

import Prelude

import Clappr (Clappr, Parent(..), Options, clappr, toNativeOptions)
import Data.Maybe (Maybe(..))
import Effect (Effect)

opts ∷ { parentId ∷ String, source ∷ String } → Options
opts { parentId, source } =
  { autoPlay: true
  , baseUrl: Nothing
  , hlsjsConfig: Nothing
  , hlsRecoverAttempts: Just 1
  , mute: false
  , parent: ParentId parentId
  , source: source
  }

main ∷
  { source ∷ String
  , parentId ∷ String
  }
  → Effect Clappr
main cfg = do
  let
    o = toNativeOptions $ opts cfg
  clappr o

