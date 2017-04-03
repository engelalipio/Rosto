//
//  logging_macros.h
//  Utility
//
//

// #ifndef logging_macros_h
// #define logging_macros_h

// DLog : log only when DEBUG is set
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@ "%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

#ifdef DEBUG
#define DCLog(fmt, ...) NSLog((@ "" fmt), ##__VA_ARGS__);
#else
#define DCLog(...)
#endif

// ALog : always displays output regardless of the DEBUG setting
#define ALog(fmt, ...) NSLog((@ "%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

// ULog : UI log to an alert dialog when DEBUG is set
#ifdef DEBUG
#define ULog(fmt, ...) {UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@ "%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@ "Ok" otherButtonTitles:nil]; [alert show]; }
#else
#define ULog(...)
#endif
