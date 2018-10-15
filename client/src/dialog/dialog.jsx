import React from 'react';
import PropTypes from 'prop-types';
import { withStyles } from '@material-ui/core/styles';
import withRoot from '../../themes/withRoot';
import {styles} from './dialog.js';
import classNames from 'classnames';

import {
DialogTitle,
Dialog,
DialogActions,
DialogContent,
  IconButton,
  Tooltip,
  Button

} from '@material-ui/core';
const AlertDialog = ({title,handleClose,handleOpen,handleOkay,open,icon,classes,children,disableConfirm=false,hidden=false,valid=false}) => {
  const hiddenClass =hidden ? classes.hidden : null;
  return (
    <div className={classNames(hiddenClass)}>
      <Tooltip title={title} >
        <IconButton onClick={handleOpen} >
            {icon}
        </IconButton>
      </Tooltip>
      <Dialog
        open={open}
        aria-labelledby="alert-dialog-title"
        aria-describedby="alert-dialog-description"
      >
        <DialogTitle id="alert-dialog-title">{title}</DialogTitle>
        <DialogContent>
          {children}
        </DialogContent>
        <DialogActions>
          <Button onClick={handleClose} color="primary" >
            Cancel
          </Button>
          { !disableConfirm ?
          <Button onClick={handleOkay} color="primary" autoFocus disabled={!valid} >
            Confirm
          </Button>
          :null }
        </DialogActions>
      </Dialog>
    </div>
  );}
    
  
  
AlertDialog.propTypes = {
    classes: PropTypes.object.isRequired,
    theme: PropTypes.object.isRequired,
    children: PropTypes.array,
    title: PropTypes.string.isRequired,
    handleClose: PropTypes.func.isRequired,
    handleOpen: PropTypes.func.isRequired,
    handleOkay: PropTypes.func.isRequired,
    open: PropTypes.bool.isRequired,
    icon: PropTypes.element.isRequired,
    hidden: PropTypes.bool,
    valid: PropTypes.bool,
    diableConfirm: PropTypes.bool
  };


export default withRoot(withStyles(styles, { withTheme: true })(AlertDialog));
