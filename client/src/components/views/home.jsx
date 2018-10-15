import React, { Component } from 'react';
import PropTypes from 'prop-types';
import classNames from 'classnames';
import { withStyles } from '@material-ui/core/styles';
import {
    IconButton,
} from '@material-ui/core';
import {
    Refresh as RefreshIcon
} from '@material-ui/icons';
import withRoot from '../../themes/withRoot';
import { styles } from './home.js';
import Pet from '../cards/pet.jsx';
import { isNullOrUndefined } from '../../utility/utility.js'
class Home extends Component {
    state = {};
    componentWillMount = () => {
        const kvs = this.props.router.location.search.split("&")
        let petId
        for (let kv of kvs) {
          const kv_pair = kv.split("=")
          const key = kv_pair[0]
          const value = kv_pair[1]
          if (key.includes("pet")){
             petId = value;
          }
          this.props.refreshPets({petId:petId})
        }
    }

    renderPets = (pets,petActive) => {
        if (isNullOrUndefined(pets)) {
            return null
        }
        return pets.map((pet, index) => {
            return (
                <Pet
                    key={index}
                    index={index}
                    pet={pet}
                    selectPet={this.props.selectPet}
                    petActive={petActive}
                />
            )
        })
    }

    render() {
        const { pets, petActive, classes } = this.props;
        const petsList = this.renderPets(pets,petActive)
        return (
            <div className={classNames(classes.root)}>
                <IconButton onClick={() => { this.props.refreshPets() }} >
                    <RefreshIcon />
                </IconButton>
                {petsList}
            </div>
        )
    }
}

Home.propTypes = {
    classes: PropTypes.object.isRequired,
    theme: PropTypes.object.isRequired,
    refreshPets: PropTypes.func.isRequired,
    selectPet: PropTypes.func.isRequired,
    pets: PropTypes.array.isRequired,
    petActive: PropTypes.object.isRequired,
};


export default withRoot(withStyles(styles, { withTheme: true })(Home));