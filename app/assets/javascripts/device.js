var userAgent = window.navigator.userAgent.toLowerCase();
 
if(userAgent.indexOf('mobile') > 0) { 
  document.write('<meta name="viewport" content="width=device-width; initial-scale=2; maximum-scale=5; user-scalable=1;">');
} else {
  document.write('<meta name="viewport" content="width=device-width; initial-scale=4; maximum-scale=5; user-scalable=1;">');
}
