//
//  BILibDummyStruct.h
//
//  Created by ToKoRo on 2013-04-08.
//

#define BILIB_STRUCT_DECLARATION(siz)                                          \
  typedef struct bilib_struct_##siz { char buff[siz]; } BILibStruct##siz

#define EXPAND_BITBARG_STRUCT(prf)                                             \
  BILIB_STRUCT_DECLARATION(prf##0);                                            \
  BILIB_STRUCT_DECLARATION(prf##1);                                            \
  BILIB_STRUCT_DECLARATION(prf##2);                                            \
  BILIB_STRUCT_DECLARATION(prf##3);                                            \
  BILIB_STRUCT_DECLARATION(prf##4);                                            \
  BILIB_STRUCT_DECLARATION(prf##5);                                            \
  BILIB_STRUCT_DECLARATION(prf##6);                                            \
  BILIB_STRUCT_DECLARATION(prf##7);                                            \
  BILIB_STRUCT_DECLARATION(prf##8);                                            \
  BILIB_STRUCT_DECLARATION(prf##9)

#define EXPAND_EXPAND_BITBARG_STRUCT(prf)                                      \
  EXPAND_BITBARG_STRUCT(prf##0);                                               \
  EXPAND_BITBARG_STRUCT(prf##1);                                               \
  EXPAND_BITBARG_STRUCT(prf##2);                                               \
  EXPAND_BITBARG_STRUCT(prf##3);                                               \
  EXPAND_BITBARG_STRUCT(prf##4);                                               \
  EXPAND_BITBARG_STRUCT(prf##5);                                               \
  EXPAND_BITBARG_STRUCT(prf##6);                                               \
  EXPAND_BITBARG_STRUCT(prf##7);                                               \
  EXPAND_BITBARG_STRUCT(prf##8);                                               \
  EXPAND_BITBARG_STRUCT(prf##9)

BILIB_STRUCT_DECLARATION(1);
BILIB_STRUCT_DECLARATION(2);
BILIB_STRUCT_DECLARATION(3);
BILIB_STRUCT_DECLARATION(4);
BILIB_STRUCT_DECLARATION(5);
BILIB_STRUCT_DECLARATION(6);
BILIB_STRUCT_DECLARATION(7);
BILIB_STRUCT_DECLARATION(8);
BILIB_STRUCT_DECLARATION(9);

EXPAND_BITBARG_STRUCT(1);
EXPAND_BITBARG_STRUCT(2);
EXPAND_BITBARG_STRUCT(3);
EXPAND_BITBARG_STRUCT(4);
EXPAND_BITBARG_STRUCT(5);
EXPAND_BITBARG_STRUCT(6);
EXPAND_BITBARG_STRUCT(7);
EXPAND_BITBARG_STRUCT(8);
EXPAND_BITBARG_STRUCT(9);

EXPAND_EXPAND_BITBARG_STRUCT(1);
EXPAND_EXPAND_BITBARG_STRUCT(2);
EXPAND_EXPAND_BITBARG_STRUCT(3);
EXPAND_EXPAND_BITBARG_STRUCT(4);
EXPAND_EXPAND_BITBARG_STRUCT(5);
EXPAND_EXPAND_BITBARG_STRUCT(6);
EXPAND_EXPAND_BITBARG_STRUCT(7);
EXPAND_EXPAND_BITBARG_STRUCT(8);
EXPAND_EXPAND_BITBARG_STRUCT(9);
EXPAND_EXPAND_BITBARG_STRUCT(10);
