import React, { Component } from 'react';
import PropTypes from 'prop-types';
import classNames from 'classnames';
import { withStyles } from '@material-ui/core/styles';
import {
  Card,
} from '@material-ui/core';

import withRoot from '../../themes/withRoot';
import { styles } from './pet.js';
import { isNullOrUndefined } from '../../utility/utility.js'

class Pet extends Component {
  state = {
  };

  isActivePet=(pet,petActive)=>{
      console.log(pet)
      console.log(petActive)
    if(isNullOrUndefined(pet)||isNullOrUndefined(petActive)){
        return false
    }
    return pet.id === petActive.id;
  }
  render(){
      const {pet,petActive,classes} = this.props
      const isActive = this.isActivePet(pet,petActive)
      console.log(isActive)
      const selected = isActive ? classes.selected : null;
      return(
          <div className={classNames(classes.root)}>
            <Card className={classNames(classes.card,selected)} onClick={() => { this.props.selectPet({pet:pet}) }}>
                {JSON.stringify(pet)}
            </Card>
          </div>
      )
  }
}


Pet.propTypes = {
    classes: PropTypes.object.isRequired,
    theme: PropTypes.object.isRequired,
    pet: PropTypes.object.isRequired,
    petActive: PropTypes.object.isRequired,
    selectPet: PropTypes.func.isRequired,
  };
  
  export default withRoot(withStyles(styles, { withTheme: true })(Pet));