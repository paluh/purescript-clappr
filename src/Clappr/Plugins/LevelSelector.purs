module Clappr.Plugins.LevelSelector where

import Clappr (Plugin, NativeOptionsRow)
import Data.Array ((:))
import Data.Function.Uncurried (Fn2, mkFn2)
import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toNullable)
import Prim.Row (class Lacks)
import Record (insert)
import Type.Prelude (SProxy(..))
import Type.Row (type (+))

foreign import levelSelector ∷ Plugin

type Level =
  { audioCodec ∷ String
  , bitrate ∷ Int
  , fragmentError ∷ Boolean
  , height ∷ Int
  , url ∷ Array String
  , urlId ∷ Int
  , videoCodec ∷ String
  , width ∷ Int
  }

type Info =
  { id ∷ Int
  , label ∷ String
  , level ∷ Level
  }

type Config =
  { title ∷ Maybe String
  , label ∷ Info → String
  }

foreign import data Undefined ∷ Type

type NativeConfig =
  { title ∷ Nullable String
  , labelCallback ∷ Fn2 Info Undefined String
  }

type ConfigRow r = ( levelSelectorConfig ∷ NativeConfig | r )

setup
  ∷ ∀ r
  . Lacks "levelSelectorConfig" r
  ⇒ Config
  → { | NativeOptionsRow + r }
  → { | NativeOptionsRow + ConfigRow + r }
setup cfg opts =
  insert (SProxy ∷ SProxy "levelSelectorConfig") cfg' opts'
  where
    cfg' =
      { title: toNullable cfg.title
      , labelCallback: mkFn2 (\level _ → cfg.label level)
      }
    opts' = opts { plugins = levelSelector : opts.plugins }
