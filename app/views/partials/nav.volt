<nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          {{ link_to('', 'Avaunt', 'class': 'navbar-brand')}}
        </div>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li class="active">{{ link_to('', 'Home')}}</li>
            <li>{{ link_to('about', 'About')}}</li>
            <li>{{ link_to('contact', 'Contact')}}</li>
          </ul>
          {{ link_to('auth/login','Sign In', 'class': 'btn btn-default navbar-btn pull-right')}}
        </div><!--/.nav-collapse -->
      </div>
    </nav>
    <div class="container">