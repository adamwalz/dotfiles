// Pretty-print output from in the interactive shell
DBQuery.prototype._prettyShell = true

// Except when we don't want to
DBQuery.prototype.ugly = function() {
  this._prettyShell = false
  return this
}
