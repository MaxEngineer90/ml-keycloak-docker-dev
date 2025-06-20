<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
        CyberShield Authentication
    <#elseif section = "form">
    <div id="kc-form">
        <div id="kc-form-wrapper">
            <!-- Custom Header with Logo -->
            <div class="login-pf-header">
                <img src="${url.resourcesPath}/img/cyber-shield.svg" alt="CyberShield Logo" class="logo">
                <h1>CyberShield</h1>
                <p class="subtitle">Secure Authentication Portal</p>
            </div>
            
            <#if realm.password>
                <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                    
                    <!-- Username/Email Field -->
                    <div class="${properties.kcFormGroupClass!}">
                        <label for="username" class="${properties.kcLabelClass!}">
                            <#if !realm.loginWithEmailAllowed>Username
                            <#elseif !realm.registrationEmailAsUsername>Username or Email
                            <#else>Email</#if>
                        </label>
                        <input tabindex="1" 
                               id="username" 
                               class="${properties.kcInputClass!}" 
                               name="username" 
                               value="${(login.username!'')}" 
                               type="text" 
                               autofocus 
                               autocomplete="username"
                               placeholder="<#if !realm.loginWithEmailAllowed>Enter your username<#elseif !realm.registrationEmailAsUsername>Enter username or email<#else>Enter your email</#if>"
                        />
                        
                        <#if messagesPerField.existsError('username','password')>
                            <span class="error-message">
                                ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                            </span>
                        </#if>
                    </div>

                    <!-- Password Field -->
                    <div class="${properties.kcFormGroupClass!}">
                        <label for="password" class="${properties.kcLabelClass!}">Password</label>
                        <input tabindex="2" 
                               id="password" 
                               class="${properties.kcInputClass!}" 
                               name="password" 
                               type="password" 
                               autocomplete="current-password"
                               placeholder="Enter your password"
                        />
                    </div>

                    <!-- Remember Me & Forgot Password -->
                    <#if realm.rememberMe && !usernameEditDisabled?? || realm.resetPasswordAllowed>
                        <div class="form-options">
                            <#if realm.rememberMe && !usernameEditDisabled??>
                                <div class="checkbox">
                                    <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" 
                                           <#if login.rememberMe??>checked</#if>>
                                    <label for="rememberMe">Remember me</label>
                                </div>
                            </#if>
                            
                            <#if realm.resetPasswordAllowed>
                                <div class="forgot-password">
                                    <a tabindex="5" href="${url.loginResetCredentialsUrl}">Forgot Password?</a>
                                </div>
                            </#if>
                        </div>
                    </#if>

                    <!-- Submit Button -->
                    <div id="kc-form-buttons" class="${properties.kcFormGroupClass!}">
                        <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                        <input tabindex="4" 
                               class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!}" 
                               name="login" 
                               id="kc-login" 
                               type="submit" 
                               value="Sign In"/>
                    </div>
                </form>
            </#if>
        </div>
    </div>

    <#elseif section = "info">
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <div id="kc-registration-container">
                <div id="kc-registration">
                    <span>No account? <a tabindex="6" href="${url.registrationUrl}">Sign up</a></span>
                </div>
            </div>
        </#if>
    </#if>

</@layout.registrationLayout>