import { Component, OnInit } from '@angular/core';
import { FormBuilder, Validators, FormGroup } from '@angular/forms';
import { GetInfoService } from '../services/get-info.service'
import { Router } from '@angular/router';

@Component({
  selector: 'app-student-sign-in',
  templateUrl: './student-sign-in.component.html',
  styleUrls: ['./student-sign-in.component.css']
})
export class StudentSignInComponent implements OnInit {

  public userSigninForm: FormGroup;

  constructor(private formBuilder: FormBuilder,private getInfoService: GetInfoService,private route : Router) { }

  ngOnInit(): void {
    this.userSigninForm = this.formBuilder.group({
      name: ['', [Validators.required]],
      uid: ['', [Validators.required]],
      password: ['',[Validators.required]]
    });
  }

  onSubmit(){
    if(this.userSigninForm.valid){
      this.getInfoService.studentSignin(this.userSigninForm.value).subscribe((data) => { });
      this.route.navigate(["/login/student"]);
    }
  }

}
