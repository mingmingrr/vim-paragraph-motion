Vim Paragraph Motion
====================

Normally the `{` and `}` motions only match completely empty lines. With
this plugin lines that only contain whitespace are also matched.

This fork also includes some new options:
- `let g:paragraphmotion_keepjumps = 1` to keep the jumplist unmodified after a jump
- `let g:paragraphmotion_skipfolds = 1` to skip over folded lines

License
=======
All files in this project are licensed under the BSD Zero Clause License (0BSD)
(see [LICENSE](LICENSE)).
