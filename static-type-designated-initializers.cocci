
// Convert CPython static types to use designated initializers.

// NEED PREPROCESSING with:
// sed -e's/PyVarObject_HEAD_INIT(\([^)]*\))/PyVarObject_HEAD_INIT_COMMA(\1),/'

//[[[cog
//
// ## Main PyTypeObject slots ##
//
//for num_fillers, field_name in reversed(list(enumerate("""
//  tp_name tp_basicsize tp_itemsize tp_dealloc tp_vectorcall_offset tp_getattr
//  tp_setattr tp_compare tp_repr tp_as_number tp_as_sequence tp_as_mapping
//  tp_hash tp_call tp_str tp_getattro tp_setattro tp_as_buffer tp_flags tp_doc
//  tp_traverse tp_clear tp_richcompare tp_weaklistoffset tp_iter tp_iternext
//  tp_methods tp_members tp_getset tp_base tp_dict tp_descr_get tp_descr_set
//  tp_dictoffset tp_init tp_alloc tp_new tp_free tp_is_gc
//""".split()))):
//    fillers = ','.join(f'E{n}' for n in range(num_fillers))
//    if fillers:
//        comma = ','
//    else:
//        comma = ''
//    print("""
//@@
//identifier typename;
//expression metatype,size,slotval%(comma)s%(fillers)s;
//@@
//
//  PyTypeObject typename = {
//  PyVarObject_HEAD_INIT_COMMA(metatype, size),
//  %(fillers)s%(comma)s
//- slotval,
//+ .%(field_name)s = slotval,
//  ...
//  };""" % locals())
//
// ## PyNumberMethods slots ##
//
//for num_fillers, field_name in reversed(list(enumerate("""
//  nb_add nb_subtract nb_multiply nb_remainder nb_divmod nb_power nb_negative
//  nb_positive nb_absolute nb_bool nb_invert nb_lshift nb_rshift nb_and
//  nb_xor nb_or nb_int nb_reserved nb_float
//  nb_inplace_add nb_inplace_subtract nb_inplace_multiply nb_inplace_remainder
//  nb_inplace_power nb_inplace_lshift nb_inplace_rshift nb_inplace_and
//  nb_inplace_xor nb_inplace_or
//  nb_floor_divide nb_true_divide nb_inplace_floor_divide
//  nb_inplace_true_divide
//  nb_index
//  nb_matrix_multiply nb_inplace_matrix_multiply
//""".split()))):
//    fillers = ','.join(f'E{n}' for n in range(num_fillers))
//    if fillers:
//        comma = ','
//    else:
//        comma = ''
//    print("""
//@@
//identifier structname;
//expression slotval%(comma)s%(fillers)s;
//@@
//
//  PyNumberMethods structname = {
//  %(fillers)s%(comma)s
//- slotval,
//+ .%(field_name)s = slotval,
//  ...
//  };""" % locals())
//
// ## PyMappingMethods slots ##
//
//for num_fillers, field_name in reversed(list(enumerate("""
//  mp_length mp_subscript mp_ass_subscript
//""".split()))):
//    fillers = ','.join(f'E{n}' for n in range(num_fillers))
//    if fillers:
//        comma = ','
//    else:
//        comma = ''
//    print("""
//@@
//identifier structname;
//expression slotval%(comma)s%(fillers)s;
//@@
//
//  PyMappingMethods structname = {
//  %(fillers)s%(comma)s
//- slotval,
//+ .%(field_name)s = slotval,
//  ...
//  };""" % locals())
//]]]

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
identifier structname;
expression slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27,E28,E29,E30,E31,E32,E33,E34;
@@

  PyNumberMethods structname = {
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27,E28,E29,E30,E31,E32,E33,E34,
- slotval,
+ .nb_inplace_matrix_multiply = slotval,
  ...
  };

@@
identifier structname;
expression slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27,E28,E29,E30,E31,E32,E33;
@@

  PyNumberMethods structname = {
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27,E28,E29,E30,E31,E32,E33,
- slotval,
+ .nb_matrix_multiply = slotval,
  ...
  };

@@
identifier structname;
expression slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27,E28,E29,E30,E31,E32;
@@

  PyNumberMethods structname = {
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27,E28,E29,E30,E31,E32,
- slotval,
+ .nb_index = slotval,
  ...
  };

@@
identifier structname;
expression slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27,E28,E29,E30,E31;
@@

  PyNumberMethods structname = {
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27,E28,E29,E30,E31,
- slotval,
+ .nb_inplace_true_divide = slotval,
  ...
  };

@@
identifier structname;
expression slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27,E28,E29,E30;
@@

  PyNumberMethods structname = {
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27,E28,E29,E30,
- slotval,
+ .nb_inplace_floor_divide = slotval,
  ...
  };

@@
identifier structname;
expression slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27,E28,E29;
@@

  PyNumberMethods structname = {
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27,E28,E29,
- slotval,
+ .nb_true_divide = slotval,
  ...
  };

@@
identifier structname;
expression slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27,E28;
@@

  PyNumberMethods structname = {
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27,E28,
- slotval,
+ .nb_floor_divide = slotval,
  ...
  };

@@
identifier structname;
expression slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27;
@@

  PyNumberMethods structname = {
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27,
- slotval,
+ .nb_inplace_or = slotval,
  ...
  };

@@
identifier structname;
expression slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26;
@@

  PyNumberMethods structname = {
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,
- slotval,
+ .nb_inplace_xor = slotval,
  ...
  };

@@
identifier structname;
expression slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25;
@@

  PyNumberMethods structname = {
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,
- slotval,
+ .nb_inplace_and = slotval,
  ...
  };

@@
identifier structname;
expression slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24;
@@

  PyNumberMethods structname = {
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,
- slotval,
+ .nb_inplace_rshift = slotval,
  ...
  };

@@
identifier structname;
expression slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23;
@@

  PyNumberMethods structname = {
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,
- slotval,
+ .nb_inplace_lshift = slotval,
  ...
  };

@@
identifier structname;
expression slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22;
@@

  PyNumberMethods structname = {
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,
- slotval,
+ .nb_inplace_power = slotval,
  ...
  };

@@
identifier structname;
expression slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21;
@@

  PyNumberMethods structname = {
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,
- slotval,
+ .nb_inplace_remainder = slotval,
  ...
  };

@@
identifier structname;
expression slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20;
@@

  PyNumberMethods structname = {
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,
- slotval,
+ .nb_inplace_multiply = slotval,
  ...
  };

@@
identifier structname;
expression slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19;
@@

  PyNumberMethods structname = {
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,
- slotval,
+ .nb_inplace_subtract = slotval,
  ...
  };

@@
identifier structname;
expression slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18;
@@

  PyNumberMethods structname = {
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,
- slotval,
+ .nb_inplace_add = slotval,
  ...
  };

@@
identifier structname;
expression slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17;
@@

  PyNumberMethods structname = {
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,
- slotval,
+ .nb_float = slotval,
  ...
  };

@@
identifier structname;
expression slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16;
@@

  PyNumberMethods structname = {
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,
- slotval,
+ .nb_reserved = slotval,
  ...
  };

@@
identifier structname;
expression slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15;
@@

  PyNumberMethods structname = {
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,
- slotval,
+ .nb_int = slotval,
  ...
  };

@@
identifier structname;
expression slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14;
@@

  PyNumberMethods structname = {
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,
- slotval,
+ .nb_or = slotval,
  ...
  };

@@
identifier structname;
expression slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13;
@@

  PyNumberMethods structname = {
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,
- slotval,
+ .nb_xor = slotval,
  ...
  };

@@
identifier structname;
expression slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12;
@@

  PyNumberMethods structname = {
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,
- slotval,
+ .nb_and = slotval,
  ...
  };

@@
identifier structname;
expression slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11;
@@

  PyNumberMethods structname = {
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,
- slotval,
+ .nb_rshift = slotval,
  ...
  };

@@
identifier structname;
expression slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10;
@@

  PyNumberMethods structname = {
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,
- slotval,
+ .nb_lshift = slotval,
  ...
  };

@@
identifier structname;
expression slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8,E9;
@@

  PyNumberMethods structname = {
  E0,E1,E2,E3,E4,E5,E6,E7,E8,E9,
- slotval,
+ .nb_invert = slotval,
  ...
  };

@@
identifier structname;
expression slotval,E0,E1,E2,E3,E4,E5,E6,E7,E8;
@@

  PyNumberMethods structname = {
  E0,E1,E2,E3,E4,E5,E6,E7,E8,
- slotval,
+ .nb_bool = slotval,
  ...
  };

@@
identifier structname;
expression slotval,E0,E1,E2,E3,E4,E5,E6,E7;
@@

  PyNumberMethods structname = {
  E0,E1,E2,E3,E4,E5,E6,E7,
- slotval,
+ .nb_absolute = slotval,
  ...
  };

@@
identifier structname;
expression slotval,E0,E1,E2,E3,E4,E5,E6;
@@

  PyNumberMethods structname = {
  E0,E1,E2,E3,E4,E5,E6,
- slotval,
+ .nb_positive = slotval,
  ...
  };

@@
identifier structname;
expression slotval,E0,E1,E2,E3,E4,E5;
@@

  PyNumberMethods structname = {
  E0,E1,E2,E3,E4,E5,
- slotval,
+ .nb_negative = slotval,
  ...
  };

@@
identifier structname;
expression slotval,E0,E1,E2,E3,E4;
@@

  PyNumberMethods structname = {
  E0,E1,E2,E3,E4,
- slotval,
+ .nb_power = slotval,
  ...
  };

@@
identifier structname;
expression slotval,E0,E1,E2,E3;
@@

  PyNumberMethods structname = {
  E0,E1,E2,E3,
- slotval,
+ .nb_divmod = slotval,
  ...
  };

@@
identifier structname;
expression slotval,E0,E1,E2;
@@

  PyNumberMethods structname = {
  E0,E1,E2,
- slotval,
+ .nb_remainder = slotval,
  ...
  };

@@
identifier structname;
expression slotval,E0,E1;
@@

  PyNumberMethods structname = {
  E0,E1,
- slotval,
+ .nb_multiply = slotval,
  ...
  };

@@
identifier structname;
expression slotval,E0;
@@

  PyNumberMethods structname = {
  E0,
- slotval,
+ .nb_subtract = slotval,
  ...
  };

@@
identifier structname;
expression slotval;
@@

  PyNumberMethods structname = {
  
- slotval,
+ .nb_add = slotval,
  ...
  };

@@
identifier structname;
expression slotval,E0,E1;
@@

  PyMappingMethods structname = {
  E0,E1,
- slotval,
+ .mp_ass_subscript = slotval,
  ...
  };

@@
identifier structname;
expression slotval,E0;
@@

  PyMappingMethods structname = {
  E0,
- slotval,
+ .mp_subscript = slotval,
  ...
  };

@@
identifier structname;
expression slotval;
@@

  PyMappingMethods structname = {
  
- slotval,
+ .mp_length = slotval,
  ...
  };
//[[[end]]]

@ remove_nulls_start @
type T = PyTypeObject || = PyNumberMethods || = PyMappingMethods;
identifier structname;
@@

  T structname = {
  ...
  };

@@
type remove_nulls_start.T;
identifier remove_nulls_start.structname;
metavariable slotname;
type t;
@@

  T structname = {
  ...,
- .slotname = (t)0,
  ...
  };

@@
type remove_nulls_start.T;
identifier remove_nulls_start.structname;
metavariable slotname;
@@

  T structname = {
  ...,
- .slotname = 0,
  ...
  };

@@
type remove_nulls_start.T;
identifier remove_nulls_start.structname;
metavariable slotname;
@@

  T structname = {
  ...,
- .slotname = NULL,
  ...
  };
