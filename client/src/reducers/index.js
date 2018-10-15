import {combineReducers} from 'redux';
import {petActive,pets,petsLoading} from './home.js';
const rootReducer=combineReducers({
   pets:combineReducers({pets,petsLoading,petActive}),
})
export default rootReducer;