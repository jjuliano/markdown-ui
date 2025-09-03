# Markdown UI - Examples & Use Cases

Real-world examples demonstrating how to use Markdown UI components to build complete interfaces.

## 🎯 Table of Contents

1. [Dashboard Example](#dashboard-example)
2. [E-commerce Product Page](#e-commerce-product-page)
3. [Admin Panel](#admin-panel)
4. [Documentation Site](#documentation-site)
5. [User Profile](#user-profile)
6. [Analytics Dashboard](#analytics-dashboard)
7. [Project Management](#project-management)
8. [Component Showcase](#component-showcase)

---

## Dashboard Example

A complete admin dashboard using multiple components:

### Markdown Input

```markdown
# System Dashboard

> Secondary Menu:
> [Dashboard](/ "active")
> [Analytics](/analytics)
> [Users](/users)
> [Settings](/settings)
> > Right Menu:
> > [Profile](/profile)
> > [Logout](/logout)

> Grid:
> > Four Wide Column:
> > > Vertical Menu:
> > > [Overview](/ "active teal item")
> > > [Server Status](/status)
> > > [Performance](/performance)
> > > [Logs](/logs)
> > > [Alerts __Label|3|red circular__](/alerts)

> > Twelve Wide Column:
> > > Segment:
> > > ## System Overview
> > > 
> > > __Progress|CPU Usage|45|indicating blue__
> > > __Progress|Memory Usage|72|indicating yellow__
> > > __Progress|Disk Usage|28|indicating green__
> > > 
> > > ### Recent Activity
> > > 
> > > __Table|striped celled|Time,Event,Status,User|09:15,User Login,__Label|Success|green__,john@example.com|09:12,File Upload,__Label|Processing|yellow__,jane@example.com|09:10,Database Backup,__Label|Complete|blue__,system__
> > > 
> > > __Button|View All Logs|primary__ __Button|Export Data|secondary__

> Info Message:
> ### System Status
> All services are operational. Next maintenance window: Saturday 2:00 AM EST.
```

### HTML Output

```html
<h1>System Dashboard</h1>

<div class="ui secondary menu">
  <a class="ui active item" href="/">Dashboard</a>
  <a class="ui item" href="/analytics">Analytics</a>
  <a class="ui item" href="/users">Users</a>
  <a class="ui item" href="/settings">Settings</a>
  <div class="ui right menu">
    <a class="ui item" href="/profile">Profile</a>
    <a class="ui item" href="/logout">Logout</a>
  </div>
</div>

<div class="ui grid">
  <div class="ui four wide column">
    <div class="ui vertical menu">
      <a class="ui active teal item" href="/">Overview</a>
      <a class="ui item" href="/status">Server Status</a>
      <a class="ui item" href="/performance">Performance</a>
      <a class="ui item" href="/logs">Logs</a>
      <a class="ui item" href="/alerts">Alerts <div class="ui red circular label">3</div></a>
    </div>
  </div>
  <div class="ui twelve wide column">
    <div class="ui segment">
      <h2>System Overview</h2>
      
      <div class="ui indicating blue progress">
        <div class="bar" style="width: 45%;">
          <div class="progress">45%</div>
        </div>
        <div class="label">CPU Usage</div>
      </div>
      
      <div class="ui indicating yellow progress">
        <div class="bar" style="width: 72%;">
          <div class="progress">72%</div>
        </div>
        <div class="label">Memory Usage</div>
      </div>
      
      <div class="ui indicating green progress">
        <div class="bar" style="width: 28%;">
          <div class="progress">28%</div>
        </div>
        <div class="label">Disk Usage</div>
      </div>
      
      <h3>Recent Activity</h3>
      
      <table class="ui striped celled table">
        <thead>
          <tr><th>Time</th><th>Event</th><th>Status</th><th>User</th></tr>
        </thead>
        <tbody>
          <tr>
            <td>09:15</td>
            <td>User Login</td>
            <td><div class="ui green label">Success</div></td>
            <td>john@example.com</td>
          </tr>
          <tr>
            <td>09:12</td>
            <td>File Upload</td>
            <td><div class="ui yellow label">Processing</div></td>
            <td>jane@example.com</td>
          </tr>
          <tr>
            <td>09:10</td>
            <td>Database Backup</td>
            <td><div class="ui blue label">Complete</div></td>
            <td>system</td>
          </tr>
        </tbody>
      </table>
      
      <button class="ui primary button">View All Logs</button>
      <button class="ui secondary button">Export Data</button>
    </div>
  </div>
</div>

<div class="ui info message">
  <div class="ui header">System Status</div>
  <p>All services are operational. Next maintenance window: Saturday 2:00 AM EST.</p>
</div>
```

---

## E-commerce Product Page

A product listing page with filtering and shopping features:

### Markdown Input

```markdown
# Online Store

> Menu:
> [Home](/)
> [Products](/products "active")
> [Categories](/categories)
> [Cart __Label|2|red circular__](/cart)
> > Right Menu:
> > [Account](/account)

> Grid:
> > Three Wide Column:
> > > Segment:
> > > ### Filters
> > > 
> > > **Price Range**
> > > __Progress|Budget|25|green__
> > > __Progress|Mid-Range|50|yellow__  
> > > __Progress|Premium|75|red__
> > > 
> > > **Categories**
> > > __Label|Electronics|blue__ __Label|Books|green__ __Label|Clothing|purple__

> > Thirteen Wide Column:
> > > Segment:
> > > ## Featured Products
> > > 
> > > __Table|celled striped|Product,Price,Rating,Stock,Action|MacBook Pro M2,__Label|$2,499|big blue__,★★★★★,__Label|In Stock|green__,__Button|Add to Cart|primary small__|iPhone 14,__Label|$999|big blue__,★★★★☆,__Label|Low Stock|yellow__,__Button|Add to Cart|primary small__|AirPods Pro,__Label|$249|big blue__,★★★★★,__Label|In Stock|green__,__Button|Add to Cart|primary small__,iPad Air,__Label|$599|big blue__,★★★★☆,__Label|Out of Stock|red__,__Button|Notify Me|secondary small disabled____

> Success Message:
> ### 🎉 Special Offer!
> Free shipping on orders over $500. Use code: **FREESHIP**

> Segment:
> ### Customer Reviews
> 
> __Progress|5 Star|80|green indicating__
> __Progress|4 Star|15|olive indicating__
> __Progress|3 Star|3|yellow indicating__
> __Progress|2 Star|1|orange indicating__
> __Progress|1 Star|1|red indicating__
```

---

## Admin Panel

User management interface with actions and status indicators:

### Markdown Input

```markdown
# User Management

> Tabular Menu:
> [Users](/users "active")
> [Roles](/roles) 
> [Permissions](/permissions)
> [Settings](/settings)

> Segment:
> ## Active Users __Label|247|blue circular__
> 
> __Table|sortable celled|Avatar,Name,Email,Role,Status,Last Login,Actions|👤,John Smith,john@company.com,__Label|Admin|red__,__Label|Online|green__,2 minutes ago,__Button|Edit|basic small__ __Button|Disable|red small__|👤,Jane Doe,jane@company.com,__Label|Manager|blue__,__Label|Away|yellow__,1 hour ago,__Button|Edit|basic small__ __Button|Message|blue small__|👤,Bob Wilson,bob@company.com,__Label|User|gray__,__Label|Offline|red__,2 days ago,__Button|Edit|basic small__ __Button|Enable|green small____

> Grid:
> > Eight Wide Column:
> > > Info Message:
> > > ### Recent Activity
> > > - 3 new user registrations today
> > > - 15 password resets this week  
> > > - 2 role changes pending approval

> > Eight Wide Column:
> > > Warning Message:
> > > ### System Alerts
> > > - __Label|High|red__ 5 failed login attempts from IP 192.168.1.100
> > > - __Label|Medium|yellow__ Disk usage at 85%
> > > - __Label|Low|green__ Scheduled backup completed

__Button|Add New User|primary large__ __Button|Export Users|secondary__ __Button|System Settings|basic__
```

---

## Analytics Dashboard

Data visualization with metrics and charts:

### Markdown Input

```markdown
# Analytics Overview

> Pointing Menu:
> [Today](/ "active")
> [This Week](/week)
> [This Month](/month)
> [Custom Range](/custom)

> Grid:
> > Four Wide Column:
> > > Segment:
> > > ### Key Metrics
> > > 
> > > **Website Traffic**
> > > __Progress|Visitors|65|blue indicating__
> > > __Label|12,543|huge blue__ visitors today
> > > 
> > > **Conversion Rate**
> > > __Progress|Conversions|23|green indicating__
> > > __Label|2.3%|huge green__ conversion rate
> > > 
> > > **Revenue**
> > > __Progress|Target|78|purple indicating__
> > > __Label|$24,891|huge purple__ total revenue

> > Twelve Wide Column:
> > > Segment:
> > > ## Traffic Sources
> > > 
> > > __Table|basic very compact|Source,Visitors,Percentage,Trend|Google Search,__Label|8,234|big blue__,__Progress|Google|66|blue__,__Label|+12%|green__|Social Media,__Label|2,891|big teal__,__Progress|Social|23|teal__,__Label|-3%|red__|Direct Traffic,__Label|1,123|big purple__,__Progress|Direct|9|purple__,__Label|+5%|green__|Email Marketing,__Label|295|big orange__,__Progress|Email|2|orange__,__Label|+18%|green____
> > > 
> > > ### Geographic Distribution
> > > 
> > > __Table|celled compact|Country,Flag,Users,Revenue|United States,__Flag|us__,__Label|5,234|blue__,$12,450|United Kingdom,__Flag|gb__,__Label|2,891|blue__,$6,780|Canada,__Flag|ca__,__Label|1,456|blue__,$3,210|Germany,__Flag|de__,__Label|987|blue__,$2,340|France,__Flag|fr__,__Label|654|blue__,$1,890__

> Success Message:
> ### 📊 Performance Update
> Traffic is up 23% compared to last month! Your SEO improvements are showing great results.
```

---

## Project Management

Task tracking and team collaboration interface:

### Markdown Input

```markdown
# Project: Website Redesign

> Secondary Pointing Menu:
> [Overview](/project/overview "active")
> [Tasks](/project/tasks)
> [Team](/project/team)  
> [Files](/project/files)
> [Timeline](/project/timeline)

> Grid:
> > Ten Wide Column:
> > > Segment:
> > > ## Project Status
> > > 
> > > **Overall Progress**
> > > __Progress|Project Completion|67|indicating success__
> > > 
> > > **Phase Breakdown**
> > > __Progress|Research|100|green__ Research & Planning
> > > __Progress|Design|85|blue indicating__ UI/UX Design  
> > > __Progress|Development|45|yellow indicating__ Frontend Development
> > > __Progress|Testing|0|red__ Quality Assurance
> > > __Progress|Deployment|0|gray__ Go Live
> > > 
> > > ## Recent Tasks
> > > 
> > > __Table|striped|Task,Assignee,Priority,Status,Due Date|Homepage Mockups,Sarah Chen,__Label|High|red__,__Label|In Progress|blue__,Mar 15|User Authentication,Mike Johnson,__Label|High|red__,__Label|Complete|green__,Mar 12|Mobile Responsive,Lisa Park,__Label|Medium|yellow__,__Label|Testing|orange__,Mar 18|Database Schema,Tom Wilson,__Label|Low|gray__,__Label|Planning|purple__,Mar 20__

> > Six Wide Column:
> > > Segment:
> > > ### Team Members
> > > 
> > > **Sarah Chen** - Lead Designer  
> > > __Label|Available|green__ __Label|Design Lead|blue__
> > > 
> > > **Mike Johnson** - Full Stack Developer  
> > > __Label|Busy|yellow__ __Label|Senior Dev|purple__
> > > 
> > > **Lisa Park** - Frontend Developer  
> > > __Label|Available|green__ __Label|Frontend|teal__
> > > 
> > > **Tom Wilson** - Backend Developer  
> > > __Label|Off|red__ __Label|Backend|orange__
> > > 
> > > > Warning Message:
> > > > ### ⚠️ Deadline Alert
> > > > Project deadline is in **12 days**. Current pace suggests delivery on schedule.

__Button|Add Task|primary__ __Button|Team Chat|blue__ __Button|Project Settings|basic__
```

---

## Documentation Site

Technical documentation with navigation and examples:

### Markdown Input

```markdown
# API Documentation

> Text Menu:
> [Getting Started](/ "active")
> [Authentication](/auth)
> [Endpoints](/endpoints)
> [Examples](/examples)
> [SDKs](/sdks)

> Grid:
> > Four Wide Column:
> > > Vertical Fluid Tabular Menu:
> > > [Quick Start](/ "active")
> > > [Installation](/install)
> > > [Configuration](/config)
> > > [Basic Usage](/usage)
> > > [Advanced](/advanced)

> > Twelve Wide Column:
> > > Segment:
> > > # Getting Started
> > > 
> > > Welcome to our API! This guide will help you get up and running quickly.
> > > 
> > > ## API Status
> > > 
> > > __Progress|API Health|98|green indicating__ __Label|Operational|green__
> > > __Progress|Response Time|125ms|blue__ __Label|Fast|blue__
> > > __Progress|Uptime|99.9%|green indicating__ __Label|Excellent|green__
> > > 
> > > ## Quick Reference
> > > 
> > > __Table|basic celled|Method,Endpoint,Description,Status|GET,/api/v1/users,Get all users,__Label|Stable|green__|POST,/api/v1/users,Create new user,__Label|Stable|green__|PUT,/api/v1/users/{id},Update user,__Label|Stable|green__|DELETE,/api/v1/users/{id},Delete user,__Label|Beta|yellow__|GET,/api/v1/analytics,Get analytics data,__Label|New|blue____

> Info Message:
> ### 💡 Pro Tip
> Use our interactive API explorer to test endpoints directly in your browser!

> Grid:
> > Eight Wide Column:
> > > Segment:
> > > ### Rate Limits
> > > 
> > > **Free Tier**
> > > __Progress|Requests|60|blue__ 1,000 requests/hour
> > > __Label|Free|green__ $0/month
> > > 
> > > **Pro Tier**  
> > > __Progress|Requests|20|yellow__ 10,000 requests/hour
> > > __Label|Pro|blue__ $29/month
> > > 
> > > **Enterprise**
> > > __Progress|Requests|5|green__ Unlimited requests
> > > __Label|Enterprise|purple__ Custom pricing

> > Eight Wide Column:
> > > Success Message:
> > > ### 🚀 New Features
> > > - Webhook support now available
> > > - GraphQL endpoint in beta  
> > > - Real-time data streaming
> > > 
> > > __Button|View Changelog|primary__ __Button|Contact Sales|secondary__
```

---

## Form Examples

### User Registration Form

Complete user registration form with field validation:

### Markdown Input

```markdown
# User Registration

> Form:
> > Fields:
> > __Field|First Name__
> > __Input|Enter your first name__

> > __Field|Last Name__
> > __Input|Enter your last name__

> > __Field|Email Address__
> > __Input|your.email@example.com__

> > __Field|Password__
> > __Input|Choose a strong password__

> > __Field|Confirm Password__
> > __Input|Repeat your password__

> > __Field|Country__
> > __Dropdown|Select your country|United States,Canada,United Kingdom,Germany,France,Australia__

> __Checkbox|I agree to the Terms and Conditions__
> __Checkbox|Subscribe to newsletter__

> __Primary Button|Create Account__
> __Button|Cancel__
```

### HTML Output

```html
<h1>User Registration</h1>

<form class="ui form">
  <div class="fields">
    <div class="field">
      <label>First Name</label>
      <div class="ui input">
        <input type="text" placeholder="Enter your first name" />
      </div>
    </div>
    <div class="field">
      <label>Last Name</label>
      <div class="ui input">
        <input type="text" placeholder="Enter your last name" />
      </div>
    </div>
    <div class="field">
      <label>Email Address</label>
      <div class="ui input">
        <input type="text" placeholder="your.email@example.com" />
      </div>
    </div>
    <div class="field">
      <label>Password</label>
      <div class="ui input">
        <input type="password" placeholder="Choose a strong password" />
      </div>
    </div>
    <div class="field">
      <label>Confirm Password</label>
      <div class="ui input">
        <input type="password" placeholder="Repeat your password" />
      </div>
    </div>
    <div class="field">
      <label>Country</label>
      <div class="ui dropdown">
        <div class="default text">Select your country</div>
        <i class="dropdown icon"></i>
        <div class="menu">
          <div class="item">United States</div>
          <div class="item">Canada</div>
          <div class="item">United Kingdom</div>
          <div class="item">Germany</div>
          <div class="item">France</div>
          <div class="item">Australia</div>
        </div>
      </div>
    </div>
  </div>

  <div class="ui checkbox">
    <input type="checkbox" />
    <label>I agree to the Terms and Conditions</label>
  </div>
  <div class="ui checkbox">
    <input type="checkbox" />
    <label>Subscribe to newsletter</label>
  </div>

  <button class="ui primary button">Create Account</button>
  <button class="ui button">Cancel</button>
</form>
```

### Error Handling Form

Form with validation errors:

```markdown
> Error Form:
> __Message|Error|error|Please correct the errors below__
> > Fields:
> > __Field|Email|error__
> > __Input|Email address|error__

> > __Field|Password|error__
> > __Input|Password|error__

> __Button|Try Again__
```

---

## Component Showcase

Demonstrating all available components in one page:

### Markdown Input

```markdown
# Component Showcase

> Menu:
> [Elements](#elements "active")
> [Collections](#collections)
> [Views](#views)
> [Modules](#modules)

## ✅ Perfect Components (100% Working)

### Tables
__Table|striped celled compact|Component,Status,Tests,Example|Table,__Label|Perfect|green__,12/12,Data tables with formatting|Progress,__Label|Perfect|green__,15/15,Progress bars with labels|Flag,__Label|Perfect|green__,1/1,Country flag icons|Menu,__Label|Perfect|green__,11/11,Navigation menus|Message,__Label|Perfect|green__,5/5,User messages and alerts|Segment,__Label|Perfect|green__,14/14,Content containers__

### Progress Bars
__Progress|Basic Progress|50|blue__
__Progress|Indicating Success|100|indicating success green__
__Progress|Warning Level|75|indicating warning yellow__
__Progress|Error State|25|indicating error red__

### Flags
World flags: __Flag|us__ __Flag|gb__ __Flag|ca__ __Flag|de__ __Flag|fr__ __Flag|jp__ __Flag|cn__ __Flag|au__

### Messages
> Success Message:
> ### ✅ Operation Successful
> Your changes have been saved successfully.

> Info Message:  
> ### ℹ️ Information
> This is an informational message with helpful details.

> Warning Message:
> ### ⚠️ Warning
> Please review the following items before proceeding.

> Error Message:
> ### ❌ Error
> An error occurred while processing your request.

### Segments
> Raised Segment:
> This is a **raised segment** that appears elevated from the page.

> Padded Segment:
> This segment has extra padding for better content spacing.

### Menus
> Secondary Menu:
> [Dashboard](/ "active")
> [Analytics](/analytics)
> [Settings](/settings)
> > Right Menu:
> > [Profile](/profile)
> > [Logout](/logout)

> Vertical Menu:
> [Inbox __Label|5|red circular__](/inbox "active")
> [Drafts](/drafts)
> [Sent](/sent)
> [Trash](/trash)

## 🔥 Near-Perfect Components (90%+)

### Buttons (98.3% Working)
__Button|Primary|primary__ __Button|Secondary|secondary__ __Button|Success|green__ __Button|Warning|yellow__ __Button|Error|red__

__Button|Icon:save|Save|labeled icon primary__ __Button|Icon:download|Download|icon blue__ __Button|Loading...|loading green__

### Dividers (88.9% Working)

Content above the divider

> Divider:
> &nbsp;

Content below the divider

## 🚧 Good Components (60%+)

### Labels (69.2% Working)
__Label|New|green__ __Label|Popular|blue__ __Label|Sale|red__ __Label|Featured|yellow__ __Label|Premium|purple__

Size variations: __Label|Mini|mini green__ __Label|Small|small blue__ __Label|Large|large red__

Shape variations: __Label|1|circular blue__ __Label|Tag Style|tag green__ __Label|Ribbon|ribbon red__

## Real-World Example: Dashboard

> Grid:
> > Four Wide Column:
> > > Segment:
> > > ### Quick Stats
> > > __Progress|Server Load|35|green indicating__
> > > __Progress|Memory Usage|67|yellow indicating__  
> > > __Progress|Storage|82|red indicating__
> > > 
> > > __Label|Online|green__ __Label|24/7|blue__ __Label|Monitored|purple__

> > Twelve Wide Column:
> > > Segment:
> > > ### System Activity
> > > __Table|compact striped|Time,Event,Status|09:45,User Login,__Label|Success|green__|09:42,File Upload,__Label|Complete|blue__|09:40,Backup Started,__Label|Running|yellow__|09:38,Alert Cleared,__Label|Resolved|green____
> > > 
> > > __Button|Refresh Data|primary__ __Button|Export Log|secondary__ __Button|System Health|basic__

> Info Message:
> ### 📊 Performance Summary  
> System performance is optimal. All services are running normally with no critical alerts.
```

---

## Ruby Integration Examples

### Dynamic Content Generation

```ruby
class MarkdownUIGenerator
  def initialize
    @parser = MarkdownUI::Parser.new
  end
  
  # Generate user table from database records
  def user_table(users)
    headers = "Name,Email,Role,Status,Actions"
    rows = users.map do |user|
      status_label = user.active? ? "__Label|Active|green__" : "__Label|Inactive|red__"
      role_label = "__Label|#{user.role}|blue__"
      actions = "__Button|Edit|basic small__ __Button|Delete|red small__"
      "#{user.name},#{user.email},#{role_label},#{status_label},#{actions}"
    end.join('|')
    
    @parser.render("__Table|striped celled|#{headers}|#{rows}__")
  end
  
  # Generate progress dashboard
  def progress_dashboard(metrics)
    progress_bars = metrics.map do |metric|
      color = metric[:value] > 80 ? 'red' : metric[:value] > 50 ? 'yellow' : 'green'
      "__Progress|#{metric[:name]}|#{metric[:value]}|indicating #{color}__"
    end.join("\n\n")
    
    @parser.render(progress_bars)
  end
  
  # Generate navigation menu
  def nav_menu(items, active_item = nil)
    menu_items = items.map do |item|
      classes = item[:path] == active_item ? "active" : ""
      "[#{item[:label]}](#{item[:path]} \"#{classes}\")"
    end.join("\n> ")
    
    @parser.render("> Menu:\n> #{menu_items}")
  end
end

# Usage example
generator = MarkdownUIGenerator.new

# Generate user management table
users = User.active.includes(:role)
user_table_html = generator.user_table(users)

# Generate metrics dashboard  
metrics = [
  {name: "CPU Usage", value: 45},
  {name: "Memory", value: 72},
  {name: "Disk Space", value: 28}
]
dashboard_html = generator.progress_dashboard(metrics)

# Generate navigation
nav_items = [
  {label: "Dashboard", path: "/"},
  {label: "Users", path: "/users"},
  {label: "Settings", path: "/settings"}
]
nav_html = generator.nav_menu(nav_items, "/users")
```

### Rails Integration

```ruby
# app/helpers/markdown_ui_helper.rb
module MarkdownUIHelper
  def markdown_ui_render(content)
    parser = MarkdownUI::Parser.new
    parser.render(content).html_safe
  end
  
  def quick_table(headers, data, options = "striped")
    headers_str = headers.join(',')
    rows_str = data.map { |row| row.join(',') }.join('|')
    markdown_ui_render("__Table|#{options}|#{headers_str}|#{rows_str}__")
  end
  
  def status_progress(label, value, threshold = 75)
    color = value > threshold ? 'red indicating' : value > 50 ? 'yellow indicating' : 'green indicating'
    markdown_ui_render("__Progress|#{label}|#{value}|#{color}__")
  end
end

# app/views/dashboard/index.html.erb
<%= markdown_ui_render "# Dashboard" %>

<%= quick_table(
  ['Metric', 'Value', 'Status'],
  [
    ['CPU Usage', '45%', status_label('Normal', 'green')],
    ['Memory', '72%', status_label('High', 'yellow')],
    ['Disk', '28%', status_label('Normal', 'green')]
  ]
) %>

<%= status_progress('System Health', 85) %>
```

This comprehensive example collection demonstrates the full range of Markdown UI capabilities, from simple components to complex real-world applications. Use these as starting points for your own projects!