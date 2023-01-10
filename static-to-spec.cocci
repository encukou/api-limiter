
// Change static type to specs for dynamic ones

// NEEDS the static types to be delfined with named initializers.

@ init_static_to_dynamic @
identifier typename;
fresh identifier specname = typename ## "_Spec";
fresh identifier slotsname = typename ## "_Slots";
expression N, S;
typedef PyTypeObject;
typedef PyType_Spec;
typedef PyType_Slot;
symbol PyType_Type;
@@

+ static PyType_Slot slotsname[] = {
+   {0, NULL},
+ };
  PyTypeObject typename = {
-   .tp_basicsize = S,
-   .tp_name = N,
  };
+ PyType_Spec specname = {
+   .name = N,
+   .basicsize = S,
+   .flags = Py_TPFLAGS_DEFAULT | Py_TPFLAGS_IMMUTABLETYPE | Py_TPFLAGS_DISALLOW_INSTANTIATION,
+   .slots = slotsname,
+ };



//[[[cog
//
//for subtable_slot, subtable_type, slotnames_str in [
//    ('tp_as_number', 'PyNumberMethods', """
//        nb_add nb_subtract nb_multiply nb_remainder nb_divmod nb_power nb_negative
//        nb_positive nb_absolute nb_bool nb_invert nb_lshift nb_rshift nb_and
//        nb_xor nb_or nb_int nb_reserved nb_float
//        nb_inplace_add nb_inplace_subtract nb_inplace_multiply nb_inplace_remainder
//        nb_inplace_power nb_inplace_lshift nb_inplace_rshift nb_inplace_and
//        nb_inplace_xor nb_inplace_or
//        nb_floor_divide nb_true_divide nb_inplace_floor_divide
//        nb_inplace_true_divide
//        nb_index
//        nb_matrix_multiply nb_inplace_matrix_multiply
//    """),
//    ('tp_as_mapping', 'PyMappingMethods', """
//        mp_length mp_subscript mp_ass_subscript
//    """),
//]:
//    print("""
//@ get_%(subtable_slot)s depends on init_static_to_dynamic @
//identifier init_static_to_dynamic.typename;
//identifier subtable;
//@@
//  PyTypeObject typename = {
//-   .%(subtable_slot)s = &subtable,
//  };
//""" % {'subtable_slot': subtable_slot, 'subtable_type': subtable_type})
//    for slot_name in reversed(slotnames_str.split()):
//        print("""
//@ get_%(slot_name)s depends on get_%(subtable_slot)s @
//identifier get_%(subtable_slot)s.subtable;
//expression E;
//@@
//  %(subtable_type)s subtable = {
//-   .%(slot_name)s = E,
//  };
//@ depends on get_%(slot_name)s @
//identifier init_static_to_dynamic.slotsname;
//expression get_%(slot_name)s.E;
//@@
//  static PyType_Slot slotsname[] = {
//+   {Py_%(slot_name)s, E},
//    ...
//  };
//""" % {'slot_name': slot_name, 'subtable_slot': subtable_slot, 'subtable_type': subtable_type})
//    print("""
//@ remove_%(subtable_type)s @
//identifier subtable;
//@@
//- %(subtable_type)s subtable = {
//- };
//""" % {'subtable_slot': subtable_slot, 'subtable_type': subtable_type})
//
//for slot_name in reversed((
//    'tp_doc', 'tp_dealloc', 'tp_iter', 'tp_iternext', 'tp_methods',
//    'tp_getattro', 'tp_setattro', 'tp_str', 'tp_getset',
// )):
//    print("""
//@ get_%(slot_name)s depends on init_static_to_dynamic @
//identifier init_static_to_dynamic.typename;
//expression E;
//@@
//  PyTypeObject typename = {
//-   .%(slot_name)s = E,
//  };
//@ depends on get_%(slot_name)s @
//identifier init_static_to_dynamic.slotsname;
//expression get_%(slot_name)s.E;
//@@
//  static PyType_Slot slotsname[] = {
//+   {Py_%(slot_name)s, E},
//    ...
//  };
//""" % {'slot_name': slot_name})
//]]]

@ get_tp_as_number depends on init_static_to_dynamic @
identifier init_static_to_dynamic.typename;
identifier subtable;
@@
  PyTypeObject typename = {
-   .tp_as_number = &subtable,
  };


@ get_nb_inplace_matrix_multiply depends on get_tp_as_number @
identifier get_tp_as_number.subtable;
expression E;
@@
  PyNumberMethods subtable = {
-   .nb_inplace_matrix_multiply = E,
  };
@ depends on get_nb_inplace_matrix_multiply @
identifier init_static_to_dynamic.slotsname;
expression get_nb_inplace_matrix_multiply.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_nb_inplace_matrix_multiply, E},
    ...
  };


@ get_nb_matrix_multiply depends on get_tp_as_number @
identifier get_tp_as_number.subtable;
expression E;
@@
  PyNumberMethods subtable = {
-   .nb_matrix_multiply = E,
  };
@ depends on get_nb_matrix_multiply @
identifier init_static_to_dynamic.slotsname;
expression get_nb_matrix_multiply.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_nb_matrix_multiply, E},
    ...
  };


@ get_nb_index depends on get_tp_as_number @
identifier get_tp_as_number.subtable;
expression E;
@@
  PyNumberMethods subtable = {
-   .nb_index = E,
  };
@ depends on get_nb_index @
identifier init_static_to_dynamic.slotsname;
expression get_nb_index.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_nb_index, E},
    ...
  };


@ get_nb_inplace_true_divide depends on get_tp_as_number @
identifier get_tp_as_number.subtable;
expression E;
@@
  PyNumberMethods subtable = {
-   .nb_inplace_true_divide = E,
  };
@ depends on get_nb_inplace_true_divide @
identifier init_static_to_dynamic.slotsname;
expression get_nb_inplace_true_divide.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_nb_inplace_true_divide, E},
    ...
  };


@ get_nb_inplace_floor_divide depends on get_tp_as_number @
identifier get_tp_as_number.subtable;
expression E;
@@
  PyNumberMethods subtable = {
-   .nb_inplace_floor_divide = E,
  };
@ depends on get_nb_inplace_floor_divide @
identifier init_static_to_dynamic.slotsname;
expression get_nb_inplace_floor_divide.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_nb_inplace_floor_divide, E},
    ...
  };


@ get_nb_true_divide depends on get_tp_as_number @
identifier get_tp_as_number.subtable;
expression E;
@@
  PyNumberMethods subtable = {
-   .nb_true_divide = E,
  };
@ depends on get_nb_true_divide @
identifier init_static_to_dynamic.slotsname;
expression get_nb_true_divide.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_nb_true_divide, E},
    ...
  };


@ get_nb_floor_divide depends on get_tp_as_number @
identifier get_tp_as_number.subtable;
expression E;
@@
  PyNumberMethods subtable = {
-   .nb_floor_divide = E,
  };
@ depends on get_nb_floor_divide @
identifier init_static_to_dynamic.slotsname;
expression get_nb_floor_divide.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_nb_floor_divide, E},
    ...
  };


@ get_nb_inplace_or depends on get_tp_as_number @
identifier get_tp_as_number.subtable;
expression E;
@@
  PyNumberMethods subtable = {
-   .nb_inplace_or = E,
  };
@ depends on get_nb_inplace_or @
identifier init_static_to_dynamic.slotsname;
expression get_nb_inplace_or.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_nb_inplace_or, E},
    ...
  };


@ get_nb_inplace_xor depends on get_tp_as_number @
identifier get_tp_as_number.subtable;
expression E;
@@
  PyNumberMethods subtable = {
-   .nb_inplace_xor = E,
  };
@ depends on get_nb_inplace_xor @
identifier init_static_to_dynamic.slotsname;
expression get_nb_inplace_xor.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_nb_inplace_xor, E},
    ...
  };


@ get_nb_inplace_and depends on get_tp_as_number @
identifier get_tp_as_number.subtable;
expression E;
@@
  PyNumberMethods subtable = {
-   .nb_inplace_and = E,
  };
@ depends on get_nb_inplace_and @
identifier init_static_to_dynamic.slotsname;
expression get_nb_inplace_and.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_nb_inplace_and, E},
    ...
  };


@ get_nb_inplace_rshift depends on get_tp_as_number @
identifier get_tp_as_number.subtable;
expression E;
@@
  PyNumberMethods subtable = {
-   .nb_inplace_rshift = E,
  };
@ depends on get_nb_inplace_rshift @
identifier init_static_to_dynamic.slotsname;
expression get_nb_inplace_rshift.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_nb_inplace_rshift, E},
    ...
  };


@ get_nb_inplace_lshift depends on get_tp_as_number @
identifier get_tp_as_number.subtable;
expression E;
@@
  PyNumberMethods subtable = {
-   .nb_inplace_lshift = E,
  };
@ depends on get_nb_inplace_lshift @
identifier init_static_to_dynamic.slotsname;
expression get_nb_inplace_lshift.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_nb_inplace_lshift, E},
    ...
  };


@ get_nb_inplace_power depends on get_tp_as_number @
identifier get_tp_as_number.subtable;
expression E;
@@
  PyNumberMethods subtable = {
-   .nb_inplace_power = E,
  };
@ depends on get_nb_inplace_power @
identifier init_static_to_dynamic.slotsname;
expression get_nb_inplace_power.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_nb_inplace_power, E},
    ...
  };


@ get_nb_inplace_remainder depends on get_tp_as_number @
identifier get_tp_as_number.subtable;
expression E;
@@
  PyNumberMethods subtable = {
-   .nb_inplace_remainder = E,
  };
@ depends on get_nb_inplace_remainder @
identifier init_static_to_dynamic.slotsname;
expression get_nb_inplace_remainder.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_nb_inplace_remainder, E},
    ...
  };


@ get_nb_inplace_multiply depends on get_tp_as_number @
identifier get_tp_as_number.subtable;
expression E;
@@
  PyNumberMethods subtable = {
-   .nb_inplace_multiply = E,
  };
@ depends on get_nb_inplace_multiply @
identifier init_static_to_dynamic.slotsname;
expression get_nb_inplace_multiply.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_nb_inplace_multiply, E},
    ...
  };


@ get_nb_inplace_subtract depends on get_tp_as_number @
identifier get_tp_as_number.subtable;
expression E;
@@
  PyNumberMethods subtable = {
-   .nb_inplace_subtract = E,
  };
@ depends on get_nb_inplace_subtract @
identifier init_static_to_dynamic.slotsname;
expression get_nb_inplace_subtract.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_nb_inplace_subtract, E},
    ...
  };


@ get_nb_inplace_add depends on get_tp_as_number @
identifier get_tp_as_number.subtable;
expression E;
@@
  PyNumberMethods subtable = {
-   .nb_inplace_add = E,
  };
@ depends on get_nb_inplace_add @
identifier init_static_to_dynamic.slotsname;
expression get_nb_inplace_add.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_nb_inplace_add, E},
    ...
  };


@ get_nb_float depends on get_tp_as_number @
identifier get_tp_as_number.subtable;
expression E;
@@
  PyNumberMethods subtable = {
-   .nb_float = E,
  };
@ depends on get_nb_float @
identifier init_static_to_dynamic.slotsname;
expression get_nb_float.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_nb_float, E},
    ...
  };


@ get_nb_reserved depends on get_tp_as_number @
identifier get_tp_as_number.subtable;
expression E;
@@
  PyNumberMethods subtable = {
-   .nb_reserved = E,
  };
@ depends on get_nb_reserved @
identifier init_static_to_dynamic.slotsname;
expression get_nb_reserved.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_nb_reserved, E},
    ...
  };


@ get_nb_int depends on get_tp_as_number @
identifier get_tp_as_number.subtable;
expression E;
@@
  PyNumberMethods subtable = {
-   .nb_int = E,
  };
@ depends on get_nb_int @
identifier init_static_to_dynamic.slotsname;
expression get_nb_int.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_nb_int, E},
    ...
  };


@ get_nb_or depends on get_tp_as_number @
identifier get_tp_as_number.subtable;
expression E;
@@
  PyNumberMethods subtable = {
-   .nb_or = E,
  };
@ depends on get_nb_or @
identifier init_static_to_dynamic.slotsname;
expression get_nb_or.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_nb_or, E},
    ...
  };


@ get_nb_xor depends on get_tp_as_number @
identifier get_tp_as_number.subtable;
expression E;
@@
  PyNumberMethods subtable = {
-   .nb_xor = E,
  };
@ depends on get_nb_xor @
identifier init_static_to_dynamic.slotsname;
expression get_nb_xor.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_nb_xor, E},
    ...
  };


@ get_nb_and depends on get_tp_as_number @
identifier get_tp_as_number.subtable;
expression E;
@@
  PyNumberMethods subtable = {
-   .nb_and = E,
  };
@ depends on get_nb_and @
identifier init_static_to_dynamic.slotsname;
expression get_nb_and.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_nb_and, E},
    ...
  };


@ get_nb_rshift depends on get_tp_as_number @
identifier get_tp_as_number.subtable;
expression E;
@@
  PyNumberMethods subtable = {
-   .nb_rshift = E,
  };
@ depends on get_nb_rshift @
identifier init_static_to_dynamic.slotsname;
expression get_nb_rshift.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_nb_rshift, E},
    ...
  };


@ get_nb_lshift depends on get_tp_as_number @
identifier get_tp_as_number.subtable;
expression E;
@@
  PyNumberMethods subtable = {
-   .nb_lshift = E,
  };
@ depends on get_nb_lshift @
identifier init_static_to_dynamic.slotsname;
expression get_nb_lshift.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_nb_lshift, E},
    ...
  };


@ get_nb_invert depends on get_tp_as_number @
identifier get_tp_as_number.subtable;
expression E;
@@
  PyNumberMethods subtable = {
-   .nb_invert = E,
  };
@ depends on get_nb_invert @
identifier init_static_to_dynamic.slotsname;
expression get_nb_invert.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_nb_invert, E},
    ...
  };


@ get_nb_bool depends on get_tp_as_number @
identifier get_tp_as_number.subtable;
expression E;
@@
  PyNumberMethods subtable = {
-   .nb_bool = E,
  };
@ depends on get_nb_bool @
identifier init_static_to_dynamic.slotsname;
expression get_nb_bool.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_nb_bool, E},
    ...
  };


@ get_nb_absolute depends on get_tp_as_number @
identifier get_tp_as_number.subtable;
expression E;
@@
  PyNumberMethods subtable = {
-   .nb_absolute = E,
  };
@ depends on get_nb_absolute @
identifier init_static_to_dynamic.slotsname;
expression get_nb_absolute.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_nb_absolute, E},
    ...
  };


@ get_nb_positive depends on get_tp_as_number @
identifier get_tp_as_number.subtable;
expression E;
@@
  PyNumberMethods subtable = {
-   .nb_positive = E,
  };
@ depends on get_nb_positive @
identifier init_static_to_dynamic.slotsname;
expression get_nb_positive.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_nb_positive, E},
    ...
  };


@ get_nb_negative depends on get_tp_as_number @
identifier get_tp_as_number.subtable;
expression E;
@@
  PyNumberMethods subtable = {
-   .nb_negative = E,
  };
@ depends on get_nb_negative @
identifier init_static_to_dynamic.slotsname;
expression get_nb_negative.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_nb_negative, E},
    ...
  };


@ get_nb_power depends on get_tp_as_number @
identifier get_tp_as_number.subtable;
expression E;
@@
  PyNumberMethods subtable = {
-   .nb_power = E,
  };
@ depends on get_nb_power @
identifier init_static_to_dynamic.slotsname;
expression get_nb_power.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_nb_power, E},
    ...
  };


@ get_nb_divmod depends on get_tp_as_number @
identifier get_tp_as_number.subtable;
expression E;
@@
  PyNumberMethods subtable = {
-   .nb_divmod = E,
  };
@ depends on get_nb_divmod @
identifier init_static_to_dynamic.slotsname;
expression get_nb_divmod.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_nb_divmod, E},
    ...
  };


@ get_nb_remainder depends on get_tp_as_number @
identifier get_tp_as_number.subtable;
expression E;
@@
  PyNumberMethods subtable = {
-   .nb_remainder = E,
  };
@ depends on get_nb_remainder @
identifier init_static_to_dynamic.slotsname;
expression get_nb_remainder.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_nb_remainder, E},
    ...
  };


@ get_nb_multiply depends on get_tp_as_number @
identifier get_tp_as_number.subtable;
expression E;
@@
  PyNumberMethods subtable = {
-   .nb_multiply = E,
  };
@ depends on get_nb_multiply @
identifier init_static_to_dynamic.slotsname;
expression get_nb_multiply.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_nb_multiply, E},
    ...
  };


@ get_nb_subtract depends on get_tp_as_number @
identifier get_tp_as_number.subtable;
expression E;
@@
  PyNumberMethods subtable = {
-   .nb_subtract = E,
  };
@ depends on get_nb_subtract @
identifier init_static_to_dynamic.slotsname;
expression get_nb_subtract.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_nb_subtract, E},
    ...
  };


@ get_nb_add depends on get_tp_as_number @
identifier get_tp_as_number.subtable;
expression E;
@@
  PyNumberMethods subtable = {
-   .nb_add = E,
  };
@ depends on get_nb_add @
identifier init_static_to_dynamic.slotsname;
expression get_nb_add.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_nb_add, E},
    ...
  };


@ remove_PyNumberMethods @
identifier subtable;
@@
- PyNumberMethods subtable = {
- };


@ get_tp_as_mapping depends on init_static_to_dynamic @
identifier init_static_to_dynamic.typename;
identifier subtable;
@@
  PyTypeObject typename = {
-   .tp_as_mapping = &subtable,
  };


@ get_mp_ass_subscript depends on get_tp_as_mapping @
identifier get_tp_as_mapping.subtable;
expression E;
@@
  PyMappingMethods subtable = {
-   .mp_ass_subscript = E,
  };
@ depends on get_mp_ass_subscript @
identifier init_static_to_dynamic.slotsname;
expression get_mp_ass_subscript.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_mp_ass_subscript, E},
    ...
  };


@ get_mp_subscript depends on get_tp_as_mapping @
identifier get_tp_as_mapping.subtable;
expression E;
@@
  PyMappingMethods subtable = {
-   .mp_subscript = E,
  };
@ depends on get_mp_subscript @
identifier init_static_to_dynamic.slotsname;
expression get_mp_subscript.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_mp_subscript, E},
    ...
  };


@ get_mp_length depends on get_tp_as_mapping @
identifier get_tp_as_mapping.subtable;
expression E;
@@
  PyMappingMethods subtable = {
-   .mp_length = E,
  };
@ depends on get_mp_length @
identifier init_static_to_dynamic.slotsname;
expression get_mp_length.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_mp_length, E},
    ...
  };


@ remove_PyMappingMethods @
identifier subtable;
@@
- PyMappingMethods subtable = {
- };


@ get_tp_getset depends on init_static_to_dynamic @
identifier init_static_to_dynamic.typename;
expression E;
@@
  PyTypeObject typename = {
-   .tp_getset = E,
  };
@ depends on get_tp_getset @
identifier init_static_to_dynamic.slotsname;
expression get_tp_getset.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_tp_getset, E},
    ...
  };


@ get_tp_str depends on init_static_to_dynamic @
identifier init_static_to_dynamic.typename;
expression E;
@@
  PyTypeObject typename = {
-   .tp_str = E,
  };
@ depends on get_tp_str @
identifier init_static_to_dynamic.slotsname;
expression get_tp_str.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_tp_str, E},
    ...
  };


@ get_tp_setattro depends on init_static_to_dynamic @
identifier init_static_to_dynamic.typename;
expression E;
@@
  PyTypeObject typename = {
-   .tp_setattro = E,
  };
@ depends on get_tp_setattro @
identifier init_static_to_dynamic.slotsname;
expression get_tp_setattro.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_tp_setattro, E},
    ...
  };


@ get_tp_getattro depends on init_static_to_dynamic @
identifier init_static_to_dynamic.typename;
expression E;
@@
  PyTypeObject typename = {
-   .tp_getattro = E,
  };
@ depends on get_tp_getattro @
identifier init_static_to_dynamic.slotsname;
expression get_tp_getattro.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_tp_getattro, E},
    ...
  };


@ get_tp_methods depends on init_static_to_dynamic @
identifier init_static_to_dynamic.typename;
expression E;
@@
  PyTypeObject typename = {
-   .tp_methods = E,
  };
@ depends on get_tp_methods @
identifier init_static_to_dynamic.slotsname;
expression get_tp_methods.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_tp_methods, E},
    ...
  };


@ get_tp_iternext depends on init_static_to_dynamic @
identifier init_static_to_dynamic.typename;
expression E;
@@
  PyTypeObject typename = {
-   .tp_iternext = E,
  };
@ depends on get_tp_iternext @
identifier init_static_to_dynamic.slotsname;
expression get_tp_iternext.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_tp_iternext, E},
    ...
  };


@ get_tp_iter depends on init_static_to_dynamic @
identifier init_static_to_dynamic.typename;
expression E;
@@
  PyTypeObject typename = {
-   .tp_iter = E,
  };
@ depends on get_tp_iter @
identifier init_static_to_dynamic.slotsname;
expression get_tp_iter.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_tp_iter, E},
    ...
  };


@ get_tp_dealloc depends on init_static_to_dynamic @
identifier init_static_to_dynamic.typename;
expression E;
@@
  PyTypeObject typename = {
-   .tp_dealloc = E,
  };
@ depends on get_tp_dealloc @
identifier init_static_to_dynamic.slotsname;
expression get_tp_dealloc.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_tp_dealloc, E},
    ...
  };


@ get_tp_doc depends on init_static_to_dynamic @
identifier init_static_to_dynamic.typename;
expression E;
@@
  PyTypeObject typename = {
-   .tp_doc = E,
  };
@ depends on get_tp_doc @
identifier init_static_to_dynamic.slotsname;
expression get_tp_doc.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_tp_doc, E},
    ...
  };

//[[[end]]]

// Handle flags

@ get_tp_flags @
identifier init_static_to_dynamic.typename;
expression E;
@@
  PyTypeObject typename = {
-   .tp_flags = E,
  };
@@
identifier init_static_to_dynamic.specname;
expression get_tp_flags.E;
expression O;
@@
  PyType_Spec specname = {
-   .flags = O,
+   .flags = O | E,
  };

// Handle tp_new: Disable the Py_TPFLAGS_IMMUTABLETYPE flag

@ get_tp_new @
identifier init_static_to_dynamic.typename;
expression E;
@@
  PyTypeObject typename = {
-   .tp_new = E,
  };
@ flag_remove_immutable depends on get_tp_new @
identifier init_static_to_dynamic.specname;
expression E;
@@
  PyType_Spec specname = {
    .flags = E,
  };
@ script:python flag_remove_immutable_py @
E << flag_remove_immutable.E;
R;
@@
flags = [f.strip() for f in E.split('|')]
coccinelle.R = ' | '.join(f for f in flags if f != 'Py_TPFLAGS_IMMUTABLETYPE')
@@
identifier init_static_to_dynamic.specname;
expression flag_remove_immutable.E;
identifier flag_remove_immutable_py.R;
@@
  PyType_Spec specname = {
-   .flags = E,
+   .flags = R,
  };
@ depends on get_tp_new @
identifier init_static_to_dynamic.slotsname;
expression get_tp_new.E;
@@
  static PyType_Slot slotsname[] = {
+   {Py_tp_new, E},
    ...
  };



// De-duplicate flags

@ flagdedup @
identifier specname;
expression E;
@@
  PyType_Spec specname = {
    .flags = E,
  };
@ script:python flagdedup_py @
E << flagdedup.E;
R;
@@
flags = [f.strip() for f in E.split('|')]
coccinelle.R = ' | '.join(sorted(set(flags), key=flags.index))
@@
identifier specname;
expression flagdedup.E;
identifier flagdedup_py.R;
@@
  PyType_Spec specname = {
-   .flags = E,
+   .flags = R,
  };

// Remove casts

@@
identifier init_static_to_dynamic.slotsname;
identifier S;
expression E;
type T;
@@

  static PyType_Slot slotsname[] = {
    ...,
-   { S, (T) E },
+   { S, E },
    ...
  };

// Remove empty declaration

@@
identifier typename;
@@
- PyTypeObject typename = {
- 	PyVarObject_HEAD_INIT_COMMA(&PyType_Type, 0),
- };
