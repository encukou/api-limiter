
// Convert CPython static types to use designated initializers.

// NEED PREPROCESSING with:
// sed -e's/PyVarObject_HEAD_INIT(\([^)]*\))/PyVarObject_HEAD_INIT_COMMA(\1),/'

@@
identifier typename;
expression metatype,size,slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27,E28,E29,E30,E31,E32,E33,E34,E35,E36,E37;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27,E28,E29,E30,E31,E32,E33,E34,E35,E36,E37,
- slotval,
+ .tp_is_gc = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27,E28,E29,E30,E31,E32,E33,E34,E35,E36;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27,E28,E29,E30,E31,E32,E33,E34,E35,E36,
- slotval,
+ .tp_free = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27,E28,E29,E30,E31,E32,E33,E34,E35;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27,E28,E29,E30,E31,E32,E33,E34,E35,
- slotval,
+ .tp_new = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27,E28,E29,E30,E31,E32,E33,E34;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27,E28,E29,E30,E31,E32,E33,E34,
- slotval,
+ .tp_alloc = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27,E28,E29,E30,E31,E32,E33;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27,E28,E29,E30,E31,E32,E33,
- slotval,
+ .tp_init = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27,E28,E29,E30,E31,E32;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27,E28,E29,E30,E31,E32,
- slotval,
+ .tp_dictoffset = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27,E28,E29,E30,E31;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27,E28,E29,E30,E31,
- slotval,
+ .tp_descr_set = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27,E28,E29,E30;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27,E28,E29,E30,
- slotval,
+ .tp_descr_get = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27,E28,E29;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27,E28,E29,
- slotval,
+ .tp_dict = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27,E28;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27,E28,
- slotval,
+ .tp_base = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27,
- slotval,
+ .tp_getset = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,
- slotval,
+ .tp_members = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,
- slotval,
+ .tp_methods = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,
- slotval,
+ .tp_iternext = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,
- slotval,
+ .tp_iter = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,
- slotval,
+ .tp_weaklistoffset = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,
- slotval,
+ .tp_richcompare = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,
- slotval,
+ .tp_clear = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,
- slotval,
+ .tp_traverse = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,
- slotval,
+ .tp_doc = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,
- slotval,
+ .tp_flags = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,
- slotval,
+ .tp_as_buffer = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,
- slotval,
+ .tp_setattro = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,
- slotval,
+ .tp_getattro = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,
- slotval,
+ .tp_str = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,
- slotval,
+ .tp_call = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,
- slotval,
+ .tp_hash = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,
- slotval,
+ .tp_as_mapping = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,
- slotval,
+ .tp_as_sequence = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,E1,E2,E3,E4,E5,E6,E7,E8,
- slotval,
+ .tp_as_number = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval,E0,E1,E2,E3,E4,E5,E6,E7;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,E1,E2,E3,E4,E5,E6,E7,
- slotval,
+ .tp_repr = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval,E0,E1,E2,E3,E4,E5,E6;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,E1,E2,E3,E4,E5,E6,
- slotval,
+ .tp_compare = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval,E0,E1,E2,E3,E4,E5;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,E1,E2,E3,E4,E5,
- slotval,
+ .tp_setattr = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval,E0,E1,E2,E3,E4;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,E1,E2,E3,E4,
- slotval,
+ .tp_getattr = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval,E0,E1,E2,E3;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,E1,E2,E3,
- slotval,
+ .tp_vectorcall_offset = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval,E0,E1,E2;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,E1,E2,
- slotval,
+ .tp_dealloc = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval,E0,E1;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,E1,
- slotval,
+ .tp_itemsize = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval,E0;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
  E0,
- slotval,
+ .tp_basicsize = slotval,
  ...
  };

@@
identifier typename;
expression metatype,size,slotval;
@@

  PyTypeObject typename = {
  PyVarObject_HEAD_INIT_COMMA(metatype, size),
- slotval,
+ .tp_name = slotval,
  ...
  };

@@
identifier typename;
metavariable slotname;
@@

  PyTypeObject typename = {
  ...,
- .slotname = 0,
  ...
  };

@@
identifier typename;
metavariable slotname;
@@

  PyTypeObject typename = {
  ...,
- .slotname = NULL,
  ...
  };
