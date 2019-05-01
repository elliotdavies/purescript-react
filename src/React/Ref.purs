module React.Ref
  ( Ref
  , ReactInstance
  , createDOMRef
  , createInstanceRef
  , getCurrentRef
  ) where

import Data.Maybe (Maybe)
import Data.Nullable (Nullable)
import Data.Nullable as Nullable
import Effect (Effect)
import Effect.Uncurried (EffectFn1, runEffectFn1)
import Prelude
import Web.HTML.HTMLElement (HTMLElement)


foreign import data ReactInstance :: Type

foreign import data Ref :: Type -> Type

------


data InstanceRef
  = InstanceRefObject (ObjectRef ReactInstance)
  | InstanceRefCallback (ReactInstance -> Effect Unit)

withRef :: ObjectRef ReactInstance -> InstanceRef
withRef = InstanceRefObject

withCallbackRef :: (ReactInstance -> Effect Unit) -> InstanceRef
withCallbackRef = InstanceRefCallback

unpackInstanceRef :: forall a. (forall b. b -> a) -> InstanceRef -> a
unpackInstanceRef f = case _ of
  InstanceRefObject obj -> f obj
  InstanceRefCallback g -> f g


-----


foreign import createRef :: forall a. Effect (Ref a)


createDOMRef :: Effect (Ref HTMLElement)
createDOMRef = createRef


createInstanceRef :: Effect (Ref ReactInstance)
createInstanceRef = createRef


foreign import getCurrentRef_ :: forall a. EffectFn1 (Ref a) (Nullable a)


getCurrentRef :: forall a. Ref a -> Effect (Maybe a)
getCurrentRef ref = Nullable.toMaybe <$> runEffectFn1 getCurrentRef_ ref
