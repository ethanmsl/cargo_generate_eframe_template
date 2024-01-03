
# default recipe to display help information
_default:
	@just --list --unsorted


# ripgrep for elements in braces -- to see mustache insertions
[no-cd]
template-rg *INSIDE:
	@ echo "-- NOTE: this is run from calling directory; not justfile directory. --"
	rg "\{\{.*{{INSIDE}}.*\}\}"
