local deno_lint_sinppet = {
	filetype = { "json" }, --可能存在多个,使用内层遍历
	keyword = "lint", --只存在一个keyword
	content = [[
  "lint": {
    "rules": {
      "tags": ["recommended"],
      "include": [
        "ban-untagged-todo",
        "camelcase",
        "default-param-last",
        "eqeqeq",
        "explicit-function-return-type",
        "no-await-in-loop",
        "no-inferrable-types",
        "no-self-compare",
        "no-sparse-arrays",
        "single-var-declarator",
        "verbatim-module-syntax"
      ]
    }
  }
]],
}

return { deno_lint_sinppet }
