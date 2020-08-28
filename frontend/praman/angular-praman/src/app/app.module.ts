import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { ReactiveFormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { StudentLoginComponent } from './student-login/student-login.component';
import { StudentSignInComponent } from './student-sign-in/student-sign-in.component';
import { CertifierLoginComponent } from './certifier-login/certifier-login.component';
import { CertifierSignInComponent } from './certifier-sign-in/certifier-sign-in.component';
import { StudentDetailsComponent } from './student-details/student-details.component';
import { CertifierDetailsComponent } from './certifier-details/certifier-details.component';
import { AddActivityComponent } from './add-activity/add-activity.component';

@NgModule({
  declarations: [
    AppComponent,
    StudentLoginComponent,
    StudentSignInComponent,
    CertifierLoginComponent,
    CertifierSignInComponent,
    StudentDetailsComponent,
    CertifierDetailsComponent,
    AddActivityComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    ReactiveFormsModule,
    RouterModule.forRoot([
      { path: 'login/student', component: StudentLoginComponent },
      { path: 'signin/student', component: StudentSignInComponent },
      { path: 'login/certifier', component: CertifierLoginComponent },
      { path: 'signin/certifier', component: CertifierSignInComponent },
      {
        path: '',
        redirectTo: 'login/student',
        pathMatch: 'full',
      },
      { path: 'student/:name',component:StudentDetailsComponent },
      { path: 'certifier/:name', component: CertifierDetailsComponent},
      { path: 'student/:name/addavtivity', component: AddActivityComponent}
    ])
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
