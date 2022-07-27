///scrButtonCheck(buttonArray)
///checks whether a button is currently being pressed
///argument0 - array containing the keyboard button in index 0 and the controller button in index 1

var buttonIn;
buttonIn = argument0;
keyboard_check_direct(buttonIn[0]);

return (keyboard_check_direct(buttonIn[0]) && global.inFocus);
