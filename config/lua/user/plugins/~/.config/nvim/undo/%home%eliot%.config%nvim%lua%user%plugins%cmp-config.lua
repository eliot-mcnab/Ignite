Vim�UnDo� s��/=`�?�`-�*����1�ڄǤ�t/��7�@      @	-- order of sources, sources with lower indices are prioritises   r   1      8       8   8   8    c)��    _�                     X        ����                                                                                                                                                                                                                                                                                                                                                             c$h�     �   W   Y   �      /				feedkey("<Plug>(vsnip-expand-or-jump)", "")5��    W                      �                     5�_�                    X       ����                                                                                                                                                                                                                                                                                                                                                             c$h�     �   W   Y   �      2-- 				feedkey("<Plug>(vsnip-expand-or-jump)", "")5��    W                      �                     5�_�                    X        ����                                                                                                                                                                                                                                                                                                                                                             c$h�     �   W   Y   �      /				feedkey("<Plug>(vsnip-expand-or-jump)", "")�   X   Y   �    �   X   Y   �    �   X   Y   �    �   X   Y   �    5��    W                      �                     �    W                     �                     �    W                     �                     �    W                     �                     �    W                     �                     �    W                     �                     �    W                     �                     �    W                     �                     5�_�                    X       ����                                                                                                                                                                                                                                                                                                                                                             c$h�     �   W   Y   �      /			f	eedkey("<Plug>(vsnip-expand-or-jump)", "")�   X   Y   �    5��    W                     �                     �    W                     �                     5�_�                   W       ����                                                                                                                                                                                                                                                                                                                            W          X   /       v���    c$i     �   V   X   �      +			elseif luasnip.expand_or_jumpable() then   /				feedkey("<Plug>(vsnip-expand-or-jump)", "")   !			elseif has_words_before() then5��    V                     b      Y               5�_�                    W       ����                                                                                                                                                                                                                                                                                                                            W          W   2       v���    c$i    �   V   X   �      $						elseif has_words_before() then5��    V                     c                     �    V                     b                     5�_�      	              W       ����                                                                                                                                                                                                                                                                                                                            W          X          v���    c$�v     �   V   X   �      !			elseif has_words_before() then   				cmp.complete()   			else5��    V                     b      2               5�_�      
           	   W       ����                                                                                                                                                                                                                                                                                                                            W          W          v���    c$�y    �   V   X   �      
						else5��    V                     c                     �    V                     b                     5�_�   	              
   >       ����                                                                                                                                                                                                                                                                                                                                                             c(4�     �   =   ?   �      C			require('luasnip').lsp_expand(args.body) -- For `luasnip` users.5��    =                     �                     �    =                     �                     5�_�   
                 >       ����                                                                                                                                                                                                                                                                                                                                                             c(4�     �   =   ?   �      A			require('luasnip.lsp_expand(args.body) -- For `luasnip` users.5��    =                     {                     5�_�                    >       ����                                                                                                                                                                                                                                                                                                                                                             c(4�     �   =   ?   �      :			require('.lsp_expand(args.body) -- For `luasnip` users.5��    =                     z                     �    =   
                  y                     5�_�                    >   
    ����                                                                                                                                                                                                                                                                                                                                                             c(4�     �   =   ?   �      8			require.lsp_expand(args.body) -- For `luasnip` users.5��    =                    r                    �    =                    r                    �    =                    r                    �    =                    r                    5�_�                    q       ����                                                                                                                                                                                                                                                                                                                                                             c(5     �   p   s   �      			vim_item.menu = ({5��    p                                         �    q                                         5�_�                    r       ����                                                                                                                                                                                                                                                                                                                                                             c(5     �   q   s   �      				nvim_lsp = 5��    q                     %                     5�_�                    r       ����                                                                                                                                                                                                                                                                                                                                                             c(5     �   q   s   �      				nvim_lsp = ""5��    q                     &                     5�_�                    r       ����                                                                                                                                                                                                                                                                                                                                                             c(5     �   q   s   �      				nvim_lsp = "[]"5��    q                     '                     5�_�                    r       ����                                                                                                                                                                                                                                                                                                                                                             c(5     �   q   s   �      				nvim_lsp = "[LSP]"5��    q                     ,                     5�_�                    ~       ����                                                                                                                                                                                                                                                                                                                                                             c(5     �   }   �   �      	sources = cmp.config.sources({5��    }                    �                     �    ~                     �                    5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             c(5     �   ~   �   �      		5��    ~                     �                     5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             c(5     �   ~   �   �      		{}5��    ~                     �                     �    ~                    �                    �    ~                    �                    �    ~   	                 �                    �    ~   
                  �                     �    ~   	                 �                    �    ~                     �                     �    ~                    �                    �    ~                     �                     �    ~                     �                     �    ~                     �                     �    ~                     �                     �    ~                     �                     �    ~                     �                     �    ~                     �                     �    ~                    �                    �    ~                    �                    �    ~                    �                    5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             c(5)     �   ~   �   �      		{ name = nvim_lsp}5��    ~                     �                     �    ~                    �                    5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             c(5*     �   ~   �   �      		{ name = 'nvim_lsp}5��    ~                     �                     �    ~                    �                    5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             c(5,     �   ~   �   �      		{ name = 'nvim_lsp' }5��    ~                     �                     5�_�                    �       ����                                                                                                                                                                                                                                                                                                                            �          �   -       v���    c(51     �      �   �      -		{ name = 'luasnip' }, -- For luasnip users.         	{ name = 'buffer' },5��                         �                     5�_�                    �       ����                                                                                                                                                                                                                                                                                                                            �          �   -       v���    c(53    �      �   �      3		{ name = 'luasnip' },       	{ name = 'buffer' },5��                        �                     5�_�                            ����                                                                                                                                                                                                                                                                                                                                                 v        c(Q:     �         �      8-- updates completion option when a character is removed   "local check_backspace = function()   	local col = vim.fn.col "." - 1   @	return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"   end5��                         E      �               5�_�                            ����                                                                                                                                                                                                                                                                                                                                                 v        c(Q;     �         �      2require("luasnip/loaders/from_vscode").lazy_load()    �         �           �         �       5��                          D                     �       2                  C                     5�_�                    ,        ����                                                                                                                                                                                                                                                                                                                            0          ,           v        c(QD     �   +   -   �      '-- functions used for super-tab mapping   #local has_words_before = function()   :  local line, col = unpack(vim.api.nvim_win_get_cursor(0))   m  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil   end5��    +                     B      �               5�_�                    ,        ����                                                                                                                                                                                                                                                                                                                            ,          ,           v        c(QE     �   )   +   ~      }    �   *   ,              �   +   -          5��    *                      A                     �    )                     @                     5�_�                     E   6    ����                                                                                                                                                                                                                                                                                                                            *          *          v        c(QV    �   D   F   }      6		['<CR>'] = cmp.mapping.confirm({ select = true }), 	5��    D   4                                       5�_�      !               f   /    ����                                                                                                                                                                                                                                                                                                                            *          *          v        c(Qd     �   e   h   }      /				nvim_lsp = "[LSP]",		-- completion from LSP5��    e   /                 �	                     5�_�       "           !   g       ����                                                                                                                                                                                                                                                                                                                            *          *          v        c(Qj     �   f   h   ~      				5��    f                     �	                     5�_�   !   #           "   g       ����                                                                                                                                                                                                                                                                                                                            *          *          v        c(Qj     �   f   h   ~      				{}5��    f                     �	                     5�_�   "   $           #   g       ����                                                                                                                                                                                                                                                                                                                            *          *          v        c(Qk     �   f   h   ~      					{ na}5��    f                     �	                     �    f                     �	                     5�_�   #   %           $   g       ����                                                                                                                                                                                                                                                                                                                            *          *          v        c(Ql     �   f   h   ~      				{ }5��    f                     �	                     �    f                     �	                     �    f                    �	                    5�_�   $   &           %   g       ����                                                                                                                                                                                                                                                                                                                            *          *          v        c(Qs     �   f   h   ~      				nvim_lua = 5��    f                     �	                     5�_�   %   '           &   g       ����                                                                                                                                                                                                                                                                                                                            *          *          v        c(Qu     �   f   h   ~      				nvim_lua = ""5��    f                     �	                     5�_�   &   (           '   g       ����                                                                                                                                                                                                                                                                                                                            *          *          v        c(Qu     �   f   h   ~      				nvim_lua = "[]"5��    f                     �	                     5�_�   '   )           (   g       ����                                                                                                                                                                                                                                                                                                                            *          *          v        c(Qw     �   f   h   ~      				nvim_lua = "[LUA]"5��    f                     �	                     5�_�   (   *           )   u       ����                                                                                                                                                                                                                                                                                                                            *          *          v        c(Q|     �   t   v   ~      		{ name = 'luasnip' },       	5��    t                     <                     5�_�   )   +           *   t       ����                                                                                                                                                                                                                                                                                                                            *          *          v        c(Q     �   s   v   ~      		{ name = 'nvim_lsp' },5��    s                    $                     5�_�   *   ,           +   u       ����                                                                                                                                                                                                                                                                                                                            *          *          v        c(Q�     �   t   v         		5��    t                     '                     5�_�   +   -           ,   u       ����                                                                                                                                                                                                                                                                                                                            *          *          v        c(Q�     �   t   v         		{}5��    t                     (                     �    t   
                  /                     �    t   	                 .                    5�_�   ,   .           -   u       ����                                                                                                                                                                                                                                                                                                                            *          *          v        c(Q�     �   t   v         		{ name = }5��    t                     0                     5�_�   -   /           .   u       ����                                                                                                                                                                                                                                                                                                                            *          *          v        c(Q�     �   t   v         		{ name = ''}5��    t                     1                     �    t                 
   1             
       �    t          
       
   1      
       
       �    t          
          1      
              �    t                 
   1             
       5�_�   .   0           /   u       ����                                                                                                                                                                                                                                                                                                                            *          *          v        c(Q�     �   t   v         		{ name = 'navigation'}5��    t                     :                     �    t                     9                     �    t                     8                     �    t                     7                     �    t                     6                     �    t                     5                     �    t                     4                     �    t                     3                     �    t                     2                     �    t                    1                    �    t                     3                     �    t                     2                     �    t                    1                    �    t                    1                    �    t                    1                    5�_�   /   1           0   u       ����                                                                                                                                                                                                                                                                                                                            *          *          v        c(Q�     �   t   v         		{ name = 'nvim_lua'}5��    t                     :                     5�_�   0   2           1   u       ����                                                                                                                                                                                                                                                                                                                            *          *          v        c(Q�    �   t   v         		{ name = 'nvim_lua' }5��    t                     <                     5�_�   1   3           2   g       ����                                                                                                                                                                                                                                                                                                                                                             c(RR     �   f   h         				nvim_lua = "[LUA]",5��    f                  	   �	              	       �    f                    �	                    �    f   )              
   �	             
       �    f   )       
          �	      
              �    f   )              
   �	             
       5�_�   2   4           3   g       ����                                                                                                                                                                                                                                                                                                                                                             c(R^   	 �   f   h         3				nvim_lua = "[LUA]",		-- LUA-specific completion5��    f                    �	                    5�_�   3   5           4   r   1    ����                                                                                                                                                                                                                                                                                                                                                             c)��     �   q   s         @	-- order of sources, sources with lower indices are prioritises5��    q   1                  �
                     �    q   3                  �
                     5�_�   4   6           5   r   3    ����                                                                                                                                                                                                                                                                                                                                                             c)��     �   q   s         B	-- order of sources, sources with lower indices beare prioritises5��    q   1                 �
                    �    q   3                 �
                    5�_�   5   7           6   r   <    ����                                                                                                                                                                                                                                                                                                                                                             c)��     �   q   s         G	-- order of sources, sources with lower indices having are prioritises5��    q   8                 �
                    5�_�   6   8           7   r   J    ����                                                                                                                                                                                                                                                                                                                                                             c)��   
 �   q   s         J	-- order of sources, sources with lower indices having higher prioritises5��    q   F                                     5�_�   7               8   r       ����                                                                                                                                                                                                                                                                                                                                                             c)��    �   q   s         G	-- order of sources, sources with lower indices having higher priority5��    q                     �
                     5�_�                    X       ����                                                                                                                                                                                                                                                                                                                                                             c$h�    �   W   Y          1				--feedkey("<Plug>(vsnip-expand-or-jump)", "")5��    W           /       1   �      /       1       5��
