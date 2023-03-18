;;; lang/solidity/config.el -*- lexical-binding: t; -*-

;;
;;; Packages

(after! eglot
  (add-to-list 'eglot-server-programs
               '(solidity-mode . ("nomicfoundation-solidity-language-server" "--stdio"))))

(after! lsp-mode
  (add-to-list 'lsp-language-id-configuration '(solidity-mode . "solidity"))
  (lsp-register-client
    (make-lsp-client :new-connection (lsp-stdio-connection '("nomicfoundation-solidity-language-server" "--stdio"))
                     :activation-fn (lsp-activate-on "solidity")
                     :priority -1
                     :server-id 'solidity-language-server)))

(after! solidity-mode
  (setq solidity-comment-style 'slash)
  (set-docsets! 'solidity-mode "Solidity")

  (if (modulep! +lsp)
      (add-hook 'solidity-mode-local-vars-hook #'lsp! 'append))

  (if (modulep! +tree-sitter)
      (add-hook 'solidity-mode-local-vars-hook #'tree-sitter! 'append)))

  ;; (set-company-backend! 'solidity-mode 'company-solidity)

  ;; (use-package! solidity-flycheck  ; included with solidity-mode
  ;;   :when (modulep! :checkers syntax)
  ;;   :config
  ;;   (setq flycheck-solidity-solc-addstd-contracts t)
  ;;   (when (funcall flycheck-executable-find solidity-solc-path)
  ;;     (add-to-list 'flycheck-checkers 'solidity-checker nil #'eq))
  ;;   (when (funcall flycheck-executable-find solidity-solium-path)
  ;;     (add-to-list 'flycheck-checkers 'solium-checker nil #'eq)))

  ;; (use-package! company-solidity
  ;;   :when (modulep! :completion company)
  ;;   :unless (modulep! +lsp)
  ;;   :after solidity-mode
  ;;   :config (delq! 'company-solidity company-backends)))
