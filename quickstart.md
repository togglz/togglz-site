---
layout: base
---

Quickstart
==========

This small tutorial will give an overview on how to get started with Togglz.

Installation
------------

First add following dependencies to your project:

    <!-- Togglz for Servlet environments (mandatory) -->
    <dependency>
      <groupId>org.togglz</groupId>
      <artifactId>togglz-servlet</artifactId>
      <version>1.0.0.Alpha3</version>
    </dependency>
    
    <!-- CDI integration (optional) -->
    <dependency>
      <groupId>org.togglz</groupId>
      <artifactId>togglz-cdi</artifactId>
      <version>1.0.0.Alpha3</version>
    </dependency>
    
    <!-- Spring integration (optional) -->
    <dependency>
      <groupId>org.togglz</groupId>
      <artifactId>togglz-spring</artifactId>
      <version>1.0.0.Alpha3</version>
    </dependency>


The artifacts are available in this Maven repository:

    <repository>
      <id>togglz</id>
      <name>Togglz Maven Repository</name>
      <url>http://chkal.github.com/togglz/repository/</url>
    </repository>

If you deploy your application to a Servlet 3.0 container, you won't have to do any further configuration.
In case your container doesn't support Servlet 3.0, you have to manually register the required Filter. Please 
refer to TODO:Installation for details.


Configuration
-------------

First create your feature enum class:

    public enum MyFeatures implements Feature {
    
        @EnabledByDefault
        @Label("First Feature")
        FEATURE_ONE,
        
        @Label("Second Feature")
        FEATURE_TWO;
        
        public boolean isActive() {
            return FeatureContext.getFeatureManager().isActive(this);
        }
        
    }

The next step is to create an implementation of `FeatureManagerConfiguration`:

    @ApplicationScoped
    public class DemoConfiguration implements FeatureManagerConfiguration {
    
        public Class<? extends Feature> getFeatureClass() {
            return MyFeatures.class;
        }
    
        public FeatureStateRepository getFeatureStateRepository() {
            return new FileBasedRepository(new File("/somewhere/features.properties"));
        }
    
        public FeatureUserProvider getFeatureUserProvider() {
            return new ServletFeatureUserProvider();
        }
    
    }

See the following short description for a description of each method:

* `getFeatureClass()`: This method is used to tell Togglz about your feature enum. Just return the class of the enum here.
* `getFeatureStateRepository()`: This method must return the feature state repository which is responsible to persist the state of features. This example uses the `FileBasedRepository` which uses Java property files to save the feature state. But Toggles provides several other implementations. Please refer to TODO:Feature State Repositories for details.
* `getFeatureUserProvider()`: This method returns a provider class that is responsible to tell the FeatureManager which is the *current user*. Togglz provides out-of-the-box integration with many popular security frameworks. Please refer to TODO:User Authentication for details.

Usage
-----

Using Togglz is very simple. To check if a feature is active just call the `isActive()` method of the corresponding feature enum value:

    if( MyFeatures.FEATURE_ONE.isActive() ) {
      // new stuff here
    }

Admin Console
-------------

Togglz ships with an embedded admin console that allows you to toggle your features:

![admin-console](/images/screenshot-admin-console.png)

To enable the embedded Togglz admin console, add the following dependency to your `pom.xml`:

    <!-- Togglz Admin Console -->
    <dependency>
      <groupId>org.togglz</groupId>
      <artifactId>togglz-console</artifactId>
      <version>1.0.0.Alpha3</version>
    </dependency> 

If you deploy your application to a Servlet 3.0 container, you won't have to do any further configuration. If your container doesn't support Servlet 3.0, you will have to manually add the `TogglzConsoleServlet` to your `/WEB-INF/web.xml`. Please refer to TODO:Installation for details.

The admin console will be available in a virtual path named `togglz` within you application. So if you application is deployed to a context path named `myapp` within the container, you will have to use the following URL: [http://localhost:8080/myapp/togglz/](http://localhost:8080/myapp/togglz/)

JSF integration
---------------

To make use of the JSF integration features, add the following module to your pom:

    <!-- JSF integration -->
    <dependency>
      <groupId>org.togglz</groupId>
      <artifactId>togglz-jsf</artifactId>
      <version>1.0.0.Alpha3</version>
    </dependency> 

The JSF integration provides a very simple way to render page content depending on whether a feature is active or not:

    <h:panelGroup rendered="#\{features.FEATURE_ONE\}">
      <!-- Some part of the page required for FEATURE_ONE -->
    </h:panelGroup>
