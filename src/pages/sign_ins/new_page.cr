class SignIns::NewPage < AuthLayout
  needs operation : SignInUser

  def content
    h1 "Sign In"
    render_sign_in_form(@operation)
  end

  private def render_sign_in_form(op)
    form_for SignIns::Create do
      sign_in_fields(op)
      submit "Sign In", flow_id: "sign-in-button", class: "btn btn-primary"
    end
    para do
      text "Don't have an account yet? "
      link "Create one!", to: SignUps::New
    end
  end

  private def sign_in_fields(op)
    mount Shared::Field, attribute: op.email, label_text: "Email", &.email_input(autofocus: "true"); br
    mount Shared::Field, attribute: op.password, label_text: "Password", &.password_input; br
  end
end
