# Changelog - Version 0.3.1

**Release Date**: January 2025

## 🚀 Major Updates: Modernized Dependencies

### ✅ Updated Dependencies

- **Redcarpet**: Updated to `3.6.1` (latest, February 2025)
- **HTMLBeautifier**: Replaced Nokogiri with `htmlbeautifier 1.4.3` for cleaner HTML formatting
- **Semantic UI**: Updated to `2.5.0` across all HTML templates and documentation
- **Ruby**: Tested and verified compatibility with Ruby 3.4.2

### 🔧 Technical Improvements

- **Replaced Nokogiri dependency** with lighter HTMLBeautifier gem
- **Fixed component gemspec issues** preventing proper bundle installation
- **Updated all CDN references** to use Semantic UI 2.5.0 from jsDelivr
- **Maintained backward compatibility** while modernizing the stack

### 🧪 Testing & Verification

- **All tests passing** with updated dependencies
- **Comprehensive compatibility testing** across multiple UI components
- **Verified blockquote handling** still works perfectly (no `&gt;` issues)
- **Performance verified** with modern gem versions

### 📚 Documentation Updates

- Updated README.md with modern dependency versions
- Added Ruby 3.4.2 compatibility information
- Updated Semantic UI version references throughout
- Clarified installation requirements

## 🛠 Architecture Notes

This release maintains the **superior master branch architecture** that leverages:

- **Redcarpet's robust blockquote parsing** (handles unlimited nesting depth)
- **Custom renderer pattern** for converting blockquotes to UI elements
- **No HTML escaping of structural `>` markers** (preserves blockquote syntax)
- **Clean separation of concerns** between parsing and rendering

## 📦 Gem Dependencies

```ruby
# Core dependencies (updated)
spec.add_dependency "redcarpet", "~> 3.6.1"      # was ~> 3.6
spec.add_dependency "htmlbeautifier", "~> 1.4"   # was nokogiri >= 1.15.0
spec.add_dependency "ostruct", ">= 0.6.0"        # unchanged
```

## 🎯 Benefits for Users

- **Faster installation** (lighter dependencies)
- **More reliable HTML formatting** with dedicated htmlbeautifier
- **Latest Semantic UI features** and bug fixes
- **Future-proof** dependency stack
- **Continued rock-solid stability** with the proven architecture

---

**Upgrade Instructions**: Simply run `bundle update` to get the latest versions. No breaking changes.

**Migration Notes**: No code changes required - this is a drop-in replacement with modernized dependencies.